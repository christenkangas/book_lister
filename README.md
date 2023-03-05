# ServicePros Technical Challenge

## Rails Version

We have created a very simple REST API that returns a JSON object of famous books. We would like you you to build a Rails application to consume the API and display the data in a pleasant and organized manner. You should consider importing the data into `ActiveRecord` models, adding ways to filter the data, limit or paginate the number of results, sort the list of books, search, or any other common data-consumption conveniences.

Creativity is welcome; there are no rules or limitations on how you perform this other than that it serves up the data from the API. Any kind of augmentation of the data from outside sources or useful extensions will be considered when analysing your submission. More importantly, have fun with this project and show us what you can bring to the team.

Please submit your completed assignment by committing your code to a GitHub repository and sending us the link. Let us know if you have any burning questions in the process. Make sure to include instructions on setting up the application so that we can run it locally, or feel free to throw it up on Fly.io or something similar (and free!) to demo it working, as well as sharing the code, and alternatively you may also run it locally and share your screen.

**For the React version, switch to the `react` branch**

## API Endpoint
https://sfof9o2xn8.execute-api.us-east-1.amazonaws.com/books

## Development environment

We provide a very barebones application to get started. This application is a default Rails 7 application with only one controller, `BooksController` that retrieves information from the endpoint specified above. Feel free to change the data fetching logic any way necessary to complete this assignment. This application was generated with Tailwind support, as well as SQLite, so there is no need to have an RDBM server like postgresql running, however most free hosting providers will require you to use PostgreSQL or MySQL, so keep that in mind if trying to deploy your version for us to grade.

### System dependencies
- Ruby 3.0.4
- Rails 7
- SQLite3


### Install the dependencies

```shell
bundle install
```


### Setup database

```shell
bin/rails db:create db:migrate
```


### Start the server locally

```shell
./bin/dev
```

Open `http://localhost:3000` in a browser.

## Helpful tips

* Keep notes on resources you've used for this project
* Failure or difficulties to complete this assignment exactly as requested isn't an automatically disqualifier, but take notes of the areas you struggled with so we can have a conversation about them.
* Keep the scope of the project simple. We really don't want anyone to have to work for days just to complete this task. We estimate that to complete the core ask in this challenge it should take roughly 4 hours of work,
* Have fun with this challenge. This task is measuring more than just your skill to complete this ask, and we are more interested in seeing how you work, think, and what things spark your curiosity.
