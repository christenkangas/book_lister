class BooksController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
    # Creates two hash maps of DB: one for book title and key, and one for book isbn and key.
    # When loading in from the API, if the book is already in the DB, update the entry instead of 
    # deleting and recreating the DB.
    mapped_by_title = {}
    mapped_by_isbn = {}
    Book.pluck(:id, :title, :isbn).each do |id, title, isbn|
      mapped_by_title[title] = id
      mapped_by_isbn[isbn] = id
    end

    # TODO - Move to Async Scheduled Process (i.e. Clockwork Gem) 
    uri = URI('https://sfof9o2xn8.execute-api.us-east-1.amazonaws.com/books')
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body, symbolize_names: true)[:body] if res.is_a?(Net::HTTPSuccess)

    # Update or Create Book Records w/ API data 
    if !json.nil?
      json.each do |book|
        book = book.with_indifferent_access
        if book_id = mapped_by_isbn[book["isbn"]]
          Book.find(book_id).update(title: book["title"], author: book["author"], year: book["year"])
        elsif book_id = mapped_by_title[book["title"]] 
          Book.find(book_id).update(author: book["author"], year: book["year"], isbn: book["isbn"])
        else
          Book.create(title: book["title"], author: book["author"], year: book["year"], isbn: book["isbn"])
        end
      end
    else
      Rails.logger.error "Internal Server Error - seeding books issue"
    end

    # Query chain book queries when specific symbol parameters are present.
    @books = Book.all
    if params[:search].present?
      @books = @books.search(params[:search])
    end
    if params[:after].present? || params[:before].present? 
      @books = @books.filter_by_year(params[:after], params[:before])
    end
    if params[:sort].present? && params[:sort_direction].present?
      @books = @books.sort_books(params[:sort], params[:sort_direction])
    end
    @books = @books.paginate(page: params[:page], per_page: 10)
  end

  private
    def book_params
      params.require(:book).permit(:title, :author, :year, :isbn)
    end
end
