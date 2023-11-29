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
      year_ended:
        case actor.year_ended do
          nil -> "Present"
          value -> value
        end
    }
  end

  def render("show-preload.json", %{actor: actor}) do
    IO.inspect actor
    %{
      data: %{
        id: actor.id,
        name: actor.name,
        last_name: actor.last_name,
        age: actor.age,
        country: actor.country,
        year_started: actor.year_started,
        year_ended:
          case actor.year_ended do
            nil -> "Present"
            value -> value
          end,
        roles: Enum.map(actor.movies_actors, fn ma ->
          %{
            character_name: ma.character_name,
            movie: %{
              id: ma.movie.id,
              title: ma.movie.title,
              year: ma.movie.release_year
            }
          }
        end)
      }
    }
  end
end
