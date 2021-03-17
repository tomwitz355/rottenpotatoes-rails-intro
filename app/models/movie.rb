class Movie < ActiveRecord::Base
  def self.all_ratings
    #return ['G','PG','PG-13','R']
    %w(G PG PG-13 R)
  end
  
  def self.filter_and_sort(selected_ratings, sorting)
    # if selected is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # don't allow selected to be nil (see below)
    Movie.where(rating:selected_ratings).order(sorting)
  end
  
end
