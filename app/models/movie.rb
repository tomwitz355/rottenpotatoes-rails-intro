class Movie < ActiveRecord::Base
  def self.all_ratings
    #return ['G','PG','PG-13','R']
    %w(G PG PG-13 R)
  end
  
  def self.filter_by_ratings(selected_ratings)
    # if selected is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # don't allow selected to be nil (see below)
    Movie.where(rating:selected_ratings)
  end
  
end
