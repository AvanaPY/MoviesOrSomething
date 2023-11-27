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
      tagline: movie.tagline
    }
    |> add_loaded_fields(movie)
  end

  # I am 1,000% sure that this is awful code design but I'm just trying out funny things
  # ok?

  @doc false
  defp _render("movies_actors.json", movie_actor) do
    MoviesWeb.MovieActorView.render("movie_actor.json", %{movie_actor: movie_actor})
  end

  @doc false
  defp _render("distributor.json", %{distributor: nil}) do
    "none"
  end

  @doc false
  defp _render("distributor.json", %{distributor: distributor}) do
    MoviesWeb.DistributorView.render("distributor.json", %{distributor: distributor})
  end

  @doc false
  defp _render("ratings.json", rating) do
    MoviesWeb.MovieRatingView.render("movie_rating.json", %{movie_rating: rating})
  end

  @doc false
  defp add_loaded_fields(map, movie) do
    map
    |> add_loaded_movies_actors(movie.movies_actors)
    |> add_loaded_distributor(movie.distributor)
    |> add_loaded_ratings(movie.ratings)
  end

  @doc false
  defp add_loaded_movies_actors(map, movies_actors) do
    if movies_actors != nil && Ecto.assoc_loaded?(movies_actors) do
      Map.put(
        map,
        :roles,
        Enum.map(movies_actors, fn a ->
          %{
            actor: a.actor.name,
            character: a.character_name
          }
        end)
      )
    else
      map
    end
  end

  @doc false
  defp add_loaded_distributor(map, distributor) do
    if distributor != nil && Ecto.assoc_loaded?(distributor) do
      Map.put(map, :distributor, _render("distributor.json", %{distributor: distributor}))
    else
      Map.put(map, :distributor, nil)
    end
  end

  @doc false
  def add_loaded_ratings(map, ratings) do
    if ratings != nil && Ecto.assoc_loaded?(ratings) do
      Map.put(map, :ratings, Enum.map(ratings, fn r -> _render("ratings.json", r) end))
    else
      map
    end
  end
end
