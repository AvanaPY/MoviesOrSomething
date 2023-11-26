defmodule MoviesWeb.MovieActorController do
  use MoviesWeb, :controller

  alias Movies.MoviesActors
  alias Movies.MoviesActors.MovieActor

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    movies_actors = MoviesActors.list_movies_actors()
    render(conn, "index.json", movies_actors: movies_actors)
  end

  def create(conn, %{"movie_actor" => movie_actor_params}) do
    with {:ok, %MovieActor{} = movie_actor} <- MoviesActors.create_movie_actor(movie_actor_params) do
      conn
      |> put_status(:created)
      |> render("show.json", movie_actor: movie_actor)
    end
  end

  def show(conn, %{"id" => id}) do
    movie_actor = MoviesActors.get_movie_actor!(id)
    render(conn, "show.json", movie_actor: movie_actor)
  end

  def update(conn, %{"id" => id, "movie_actor" => movie_actor_params}) do
    movie_actor = MoviesActors.get_movie_actor!(id)

    with {:ok, %MovieActor{} = movie_actor} <- MoviesActors.update_movie_actor(movie_actor, movie_actor_params) do
      render(conn, "show.json", movie_actor: movie_actor)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie_actor = MoviesActors.get_movie_actor!(id)

    with {:ok, %MovieActor{}} <- MoviesActors.delete_movie_actor(movie_actor) do
      send_resp(conn, :no_content, "")
    end
  end
end
