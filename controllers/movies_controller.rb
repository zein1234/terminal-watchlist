require_relative '../models/movie'
require_relative '../views/movies_view'
require_relative '../api/movies_api'

class MoviesController
  def initialize(movie_repository)
    @movie_repository = movie_repository
    @movies_view = MoviesView.new
    @movies_api = MoviesApi.new
  end

  def add
    # ask user for name of movie and save in variable called name
    name = @movies_view.ask_user_for("What is the name of the movie?")
    # ask user for description...
    description = @movies_view.ask_user_for("What is the movie about?")
    # ask user for rating...
    rating = @movies_view.ask_user_for("How would you rate the movie out of 10?").to_f
    # ask user for year of movie and save in variable called year
    year = @movies_view.ask_user_for("What is the year that the movie was released?")
    # create new instance of movie
    movie = Movie.new({
      name: name,
      description: description,
      rating: rating,
      year: year
    })
    # store movie in repository using create
    @movie_repository.create(movie)
    # call display movies
    display_movies
  end

  def import
    # Get the name of a film to search the API save to variable called query
    query = @movies_view.ask_user_for("What is the name of the movie?")
    # query the api and capture the response.
    results = @movies_api.query(query)
    # display the response to the user.
    @movies_view.display(results)
    # Give the user a message about selecting the data.
    finish = false
    puts "Please select a movie you would like to save?"
    puts "Once you have selected all of the movies you would like to save, type exit"
    # use an until loop to allow the user to select multiple movies.
    until finish
      print "> "
      selection = gets.chomp
      finish = true if selection == "exit"

      unless selection == "exit"
        film = results[selection.to_i - 1]
        @movie_repository.create(film)

        puts "You have saved: #{film.name}"
        puts "Please select another film to save or 'exit'"
      end
    end
  end

  def list
    display_movies
  end

  private

  def display_movies
    movies = @movie_repository.all
    @movies_view.display(movies)
  end
end
