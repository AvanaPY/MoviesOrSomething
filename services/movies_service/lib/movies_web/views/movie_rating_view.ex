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
    |> insert_loaded_user(movie_rating)
  end

  defp insert_loaded_user(map, movie_rating) do
    case Ecto.assoc_loaded?(movie_rating.user) do
      true -> Map.put(map, :user, %{
        id: movie_rating.user.id,
        username: movie_rating.user.username
      })
      false -> Map.put(map, :user, "N/A")
    end
  end
end
