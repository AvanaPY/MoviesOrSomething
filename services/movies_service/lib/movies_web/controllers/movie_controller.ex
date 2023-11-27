defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller

  alias Movies.Moviez
  alias Movies.Moviez.Movie

  action_fallback MoviesWeb.FallbackController

  def index(%{params: %{"detailed" => "true"}} = conn, _params) do
    movies = Moviez.list_movies()
    movies = Enum.map(movies, fn m -> Movies.Repo.preload(m, [:actors, :distributor, :ratings]) end)
    render(conn, "index.json", movies: movies)
  end

  def index(conn, _params) do
    movies = Moviez.list_movies()
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{"movie" => movie_params}) do
    with {_res, %Movie{} = movie} <- Moviez.create_movie(movie_params) do
      conn
      |> put_status(:created)
      |> render("show.json", movie: movie)
    end
  end

  def show(conn, %{"detailed" => "true", "id" => id}) do
    movie = Moviez.get_movie!(id, %{detailed: true})
    render(conn, "show.json", movie: movie)
  end

  def show(conn, %{"id" => id}) do
    movie = Moviez.get_movie!(id)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"movie" => movie_params} = params) do
    IO.inspect conn
    IO.inspect params
    %{"title" => title} = movie_params
    movie = case Moviez.get_by_tile(title) do
      nil -> {:ok, m} = Moviez.create_movie(movie_params)
             m
      m -> m
    end

    actors = case Map.get(movie_params, "actors") do
      nil -> []
      actors -> actors
    end

    distributor = Map.get(movie_params, "distributor")

    with {:ok, %Movie{} = movie} <- Moviez.update_movie(movie, actors, distributor, movie_params),
                           movie <- Moviez.get_movie!(movie.id) do
      render(conn, "show.json", movie: movie)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Moviez.get_movie!(id)

    with {:ok, %Movie{}} <- Moviez.delete_movie(movie) do
      send_resp(conn, :no_content, "")
    end
  end
end
