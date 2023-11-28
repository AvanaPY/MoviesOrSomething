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
      name: actor.name,
      last_name: actor.last_name,
      age: actor.age,
      country: actor.country,
      year_started: actor.year_started,
      year_ended: case actor.year_ended do
                    nil -> "Present"
                    value -> value
                  end
    }
  end
end
