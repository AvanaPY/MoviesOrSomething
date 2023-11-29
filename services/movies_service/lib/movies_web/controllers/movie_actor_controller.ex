defmodule MoviesWeb.MovieActorController do
  use MoviesWeb, :controller

  alias Movies.MoviesActors
  alias Movies.MoviesActors.MovieActor
  alias Movies.Moviez
  alias Movies.Moviez.Movie
  alias Movies.Actors
  alias Movies.Actors.Actor

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    movies_actors = MoviesActors.list_movies_actors()
    render(conn, "index.json", movies_actors: movies_actors)
  end

  def create(conn, %{
        "movie_name" => movie_name,
        "actor_name" => actor_name,
        "movie_actor" => movies_actor_params
      }) do
    with {:ok, %Movie{} = movie} <- Moviez.get_by_tile(movie_name),
         {:ok, %Actor{} = actor} <- Actors.get_by_full_name(actor_name) do
      movie_actor =
        case MoviesActors.get_movie_actor_by(movie.id, actor.id) do
          {:error, :not_found} ->
            Ecto.build_assoc(movie, :movies_actors)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:actor, actor)
            |> MovieActor.changeset(movies_actor_params)
            |> Movies.Repo.insert!()

          {:ok, movie_actor} ->
            movie_actor
        end

      render(conn, "show.json", movie_actor: movie_actor)
    end
  end

  def create(conn, %{
        "movie_id" => movie_id,
        "actor_id" => actor_id,
        "movie_actor" => movies_actor_params
      }) do
    with %Movie{} = movie <- Moviez.get_movie!(movie_id),
         %Actor{} = actor <- Actors.get_actor!(actor_id) do
      movie_actor =
        case MoviesActors.get_movie_actor_by(movie_id, actor_id) do
          {:error, :not_found} ->
            Ecto.build_assoc(movie, :movies_actors)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:actor, actor)
            |> MovieActor.changeset(movies_actor_params)
            |> Movies.Repo.insert!()

          {:ok, movie_actor} ->
            movie_actor
        end

      render(conn, "show.json", movie_actor: movie_actor)
    end
  end

  def show(conn, %{"id" => id}) do
    movie_actor = MoviesActors.get_movie_actor!(id)
    render(conn, "show.json", movie_actor: movie_actor)
  end

  def update(conn, %{"id" => id, "movie_actor" => movie_actor_params}) do
    movie_actor = MoviesActors.get_movie_actor!(id)

    with {:ok, %MovieActor{} = movie_actor} <-
           MoviesActors.update_movie_actor(movie_actor, movie_actor_params) do
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
