defmodule MoviesWeb.ActorView do
  use MoviesWeb, :view
  alias MoviesWeb.ActorView

  def render("index.json", %{actors: actors}) do
    %{data: render_many(actors, ActorView, "actor.json")}
  end

  def render("show.json", %{actor: actor}) do
    %{data: render_one(actor, ActorView, "actor.json")}
  end

  def render("actor.json", %{actor: actor}) do
    %{
      id: actor.id,
      name: actor.name
    }
  end
end
