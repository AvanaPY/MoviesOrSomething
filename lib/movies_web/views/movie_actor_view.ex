defmodule MoviesWeb.MovieActorView do
  use MoviesWeb, :view
  alias MoviesWeb.MovieActorView

  def render("index.json", %{movies_actors: movies_actors}) do
    %{data: render_many(movies_actors, MovieActorView, "movie_actor.json")}
  end

  def render("show.json", %{movie_actor: movie_actor}) do
    %{data: render_one(movie_actor, MovieActorView, "movie_actor.json")}
  end

  def render("movie_actor.json", %{movie_actor: movie_actor}) do
    %{
      id: movie_actor.id
    }
  end
end
