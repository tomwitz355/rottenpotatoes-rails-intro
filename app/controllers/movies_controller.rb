class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  #  @movies = Movie.all
    @all_ratings = Movie.all_ratings
    @selected_ratings_hash = params[:ratings] || select_all_hash
    @selected_ratings = selected_ratings
    @sorting = params[:sorting] || "id"
    determine_highlighting
    @movies = Movie.filter_and_sort(@selected_ratings, @sorting)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def selected_ratings
    @selected_ratings_hash&.keys
  end
  
  def select_all_hash
    #{"G"=>"1", "PG"=>"1", "PG-13"=>"1", "R"=>"1"}
    Hash[@all_ratings.map { |rating| [rating, "1"]}]
  end
  
  def determine_highlighting
    @highlight = {:title => "", :release_date => "", :id => ""}
    #"bg-warning hilite"
    @highlight[@sorting]="bg-warning hilite"
  end
end
