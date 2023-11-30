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
      user_id: movie_rating.user_id,
      rating: movie_rating.rating,
      title: movie_rating.title,
      description: movie_rating.description
    }
  end
end
