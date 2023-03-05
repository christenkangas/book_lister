class Book < ApplicationRecord

  # Search case insensitive subsets of book attributes
  def self.search(text)
    query = self.where({})
    query.where(
      "lower(title) LIKE ? OR lower(author) LIKE ? OR year LIKE ? OR lower(isbn) LIKE ?",
      # https://thoughtbot.com/blog/ruby-splat-operator
      *(["%#{text.downcase}%"] * 4)
    )
  end

  # Search by book year inclusively
  def self.filter_by_year(after, before)
    query = self.where({})
    if after.present?
      query = query.where("year >= ?", after)
    end
    if before.present?
      query = query.where("year <= ?", before)
    end
    return query
  end

  # Sort a subset of book attributes in ascending/descending order 
  def self.sort_books(sort, sort_direction)
    sort = sort&.to_sym
    sort_direction = sort_direction&.to_sym
    query = self.where({})
    if sort == :title
      query = query.order(title: sort_direction)
    elsif sort == :author
      query = query.order(author: sort_direction)
    elsif sort == :year
      query = query.order(year: sort_direction)
    elsif sort == :isbn
      query = query.order(isbn: sort_direction)
    end
    return query
  end
end
