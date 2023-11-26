defmodule MoviesWeb.MovieView do
  use MoviesWeb, :view
  alias MoviesWeb.MovieView

  def render("index.json", %{movies: movies}) do
    %{data: render_many(movies, MovieView, "movie.json")}
  end

  def render("show.json", %{movie: movie}) do
    %{data: render_one(movie, MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{
      id: movie.id,
      title: movie.title,
      tagline: movie.tagline,
      actors: Enum.map(movie.actors, fn a -> render("actor.json", a) end),
      distributor: render("distributor.json", %{distributor: movie.distributor})
    }
  end

  def render("actor.json", actor) do
    MoviesWeb.ActorView.render("actor.json", %{actor: actor})
  end

  def render("distributor.json", %{distributor: nil}) do
    "none"
  end

  def render("distributor.json", %{distributor: distributor}) do
    IO.inspect distributor
    MoviesWeb.DistributorView.render("distributor.json", %{distributor: distributor})
  end
end
