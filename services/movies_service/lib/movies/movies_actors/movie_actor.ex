defmodule Movies.MoviesActors.MovieActor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies_actors" do
    field :character_name, :string
    belongs_to :movie, Movies.Moviez.Movie
    belongs_to :actor, Movies.Actors.Actor
  end

  @doc false
  def changeset(movie_actor, attrs) do
    movie_actor
    |> cast(attrs, [:movie_id, :actor_id, :character_name])
    |> validate_required([:movie_id, :character_name])
    |> validate_length(:character_name, min: 1)
  end
end
