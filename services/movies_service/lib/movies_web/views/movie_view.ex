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
    }
    |> add_loaded_fields(movie)
  end

  defp _render("actor.json", actor) do
    MoviesWeb.ActorView.render("actor.json", %{actor: actor})
  end

  defp _render("distributor.json", %{distributor: nil}) do
    "none"
  end

  defp _render("distributor.json", %{distributor: distributor}) do
    MoviesWeb.DistributorView.render("distributor.json", %{distributor: distributor})
  end

  defp _render("ratings.json", rating) do
    MoviesWeb.MovieRatingView.render("movie_rating.json", %{movie_rating: rating})
  end

  @doc false
  defp add_loaded_fields(map, movie) do
    map
    |> add_loaded_actors(movie.actors)
    |> add_loaded_distributor(movie.distributor)
    |> add_loaded_ratings(movie.ratings)
  end

  defp add_loaded_actors(map, actors) do
    if actors != nil && Ecto.assoc_loaded?(actors) do
      Map.put(map, :actors, Enum.map(actors, fn a -> _render("actor.json", a) end))
    else
      map
    end
  end

  defp add_loaded_distributor(map, distributor) do
    if distributor != nil && Ecto.assoc_loaded?(distributor) do
      Map.put(map, :distributor, _render("distributor.json", %{distributor: distributor}))
    else
      map
    end
  end

  def add_loaded_ratings(map, ratings) do
    if ratings != nil && Ecto.assoc_loaded?(ratings) do
      Map.put(map, :ratings, Enum.map(ratings, fn r -> _render("ratings.json", r) end))
    else
      map
    end
  end
end
