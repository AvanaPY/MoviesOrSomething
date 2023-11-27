defmodule MoviesWeb.MovieRatingView do
  use MoviesWeb, :view
  alias MoviesWeb.MovieRatingView

  def render("index.json", %{movie_ratings: movie_ratings}) do
    %{data: render_many(movie_ratings, MovieRatingView, "movie_rating.json")}
  end

  def render("show.json", %{movie_rating: movie_rating}) do
    %{data: render_one(movie_rating, MovieRatingView, "movie_rating.json")}
  end

  def render("movie_rating.json", %{movie_rating: movie_rating}) do
    %{
      id: movie_rating.id,
      rating: movie_rating.rating
    }
  end
end
