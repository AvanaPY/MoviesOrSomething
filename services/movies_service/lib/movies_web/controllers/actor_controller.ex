defmodule MoviesWeb.ActorController do
  use MoviesWeb, :controller

  alias Movies.Actors
  alias Movies.Actors.Actor

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    actors = Actors.list_actors()
    render(conn, "index.json", actors: actors)
  end

  def create(conn, %{"actor" => actor_params}) do
    with {:ok, %Actor{} = actor} <- Actors.create_actor(actor_params) do
      conn
      |> put_status(:created)
      |> render("show.json", actor: actor)
    end
  end

  def create(conn, _) do
    IO.inspect conn
    text conn, "OWO"
  end

  def show(conn, %{"id" => id}) do
    actor = Actors.get_actor!(id)
    render(conn, "show.json", actor: actor)
  end

  def update(conn, %{"id" => id, "actor" => actor_params}) do
    actor = Actors.get_actor!(id)

    with {:ok, %Actor{} = actor} <- Actors.update_actor(actor, actor_params) do
      render(conn, "show.json", actor: actor)
    end
  end

  def delete(conn, %{"id" => id}) do
    actor = Actors.get_actor!(id)

    with {:ok, %Actor{}} <- Actors.delete_actor(actor) do
      send_resp(conn, :no_content, "")
    end
  end
end
