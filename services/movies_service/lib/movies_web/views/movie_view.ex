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
      release_year: movie.release_year,
      director: movie.director,
      length_minutes: movie.length_minutes,
      language: movie.language,
      budget: movie.budget,
      box_office:
        case movie.box_office do
          nil -> "N/A"
          n -> n
        end
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

  defp _render("actor.json", actor) do
    MoviesWeb.ActorView.render("actor.json", %{actor: actor})
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
          case Ecto.assoc_loaded?(a.actor) do
            true ->
              %{
                actor: _render("actor.json", a.actor),
                role: %{
                  character_name: a.character_name
                }
              }

            false ->
              %{
                actor: "N/A",
                role: %{
                  character_name: a.character_name
                }
              }
          end
        end)
      )
    else
      Map.put(map, :roles, "N/A")
    end
  end

  @doc false
  defp add_loaded_distributor(map, distributor) do
    if distributor != nil && Ecto.assoc_loaded?(distributor) do
      Map.put(map, :distributor, _render("distributor.json", %{distributor: distributor}))
    else
      Map.put(map, :distributor, "N/A")
    end
  end

  @doc false
  def add_loaded_ratings(map, ratings) do
    if ratings != nil && Ecto.assoc_loaded?(ratings) do
      Map.put(map, :ratings, Enum.map(ratings, fn r -> _render("ratings.json", r) end))
    else
      Map.put(map, :ratings, "N/A")
    end
  end
end
