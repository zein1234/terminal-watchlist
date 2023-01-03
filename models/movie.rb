class Movie
  attr_accessor :id
  attr_reader :name, :description, :rating, :year
  def initialize(attr = {})
    @id = attr[:id]
    @name = attr[:name]
    @description = attr[:description]
    @rating = attr[:rating]
    @year = attr[:year]
  end
end
