require 'pry'

class Movie
  attr_accessor :title, :release_date, :director, :summary

  @@movies = []

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date
    @director = director
    @summary = summary
    @@movies << self
  end

  def url
    self.title.downcase.gsub(" ","_")+(".html")
  end

  def self.all
    @@movies
  end

  def self.reset_movies!
    @@movies.clear
  end

  def self.make_movies!
    movie = 'spec/fixtures/movies.txt'
    file = File.readlines(movie)
    file2 = file.map { |x| x.split(" - ") }
    file2.each { |x|
        Movie.new(x[0], x[1].to_i, x[2], x[3])
    }
  end

  def self.recent
    @@movies.select { |x| x.release_date >= 2012}
  end



end
#
#  The class itself will need to implement a method that
# parses through a text file and creates Movie instances based upon the data in that file.
