defmodule MoviesWeb.MovieRatingController do
  use MoviesWeb, :controller

  alias Movies.MovieRatings
  alias Movies.MovieRatings.MovieRating

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    movie_ratings = MovieRatings.list_movie_ratings()
    render(conn, "index.json", movie_ratings: movie_ratings)
  end

  def create(conn, %{"movie_rating" => movie_rating_params}) do
    with {:ok, %MovieRating{} = movie_rating} <- MovieRatings.create_movie_rating(movie_rating_params) do
      conn
      |> put_status(:created)
      |> render("show.json", movie_rating: movie_rating)
    end
  end

  def show(conn, %{"id" => id}) do
    movie_rating = MovieRatings.get_movie_rating!(id)
    render(conn, "show.json", movie_rating: movie_rating)
  end

  def update(conn, %{"id" => id, "movie_rating" => movie_rating_params}) do
    movie_rating = MovieRatings.get_movie_rating!(id)

    with {:ok, %MovieRating{} = movie_rating} <- MovieRatings.update_movie_rating(movie_rating, movie_rating_params) do
      render(conn, "show.json", movie_rating: movie_rating)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie_rating = MovieRatings.get_movie_rating!(id)

    with {:ok, %MovieRating{}} <- MovieRatings.delete_movie_rating(movie_rating) do
      send_resp(conn, :no_content, "")
    end
  end
end
