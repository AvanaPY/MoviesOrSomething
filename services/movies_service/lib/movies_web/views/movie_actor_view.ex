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
      movie: MoviesWeb.MovieView.render("movie.json", %{movie: movie_actor.movie}),
      actor: movie_actor.actor_id,
      character: movie_actor.character_name
    }
  end
end
