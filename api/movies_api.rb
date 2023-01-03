require_relative "../models/movie"
require 'json'
require 'open-uri'

class MoviesApi
  def query(query)
    apikey = "dc68d872f8ea40846e7c7791d8b4b07f"
    url = "https://api.themoviedb.org/3/search/movie?api_key=#{apikey}&query=#{query}"
    movie_serilalized = URI.open(url).read
    response = JSON.parse(movie_serilalized)["results"]
    filter_response(response)
  end

  private

  def filter_response(data)
    data.map do |film|
      Movie.new({
        name: film["original_title"],
        description: film["overview"],
        rating: film["vote_average"],
        year: film["release_date"]&.split("-")&.first
      })
    end
  end
end
