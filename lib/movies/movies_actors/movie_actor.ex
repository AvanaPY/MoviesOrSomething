defmodule Movies.MoviesActors.MovieActor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies_actors" do

    field :movie_id, :id
    field :actor_id, :id
  end

  @doc false
  def changeset(movie_actor, attrs) do
    movie_actor
    |> cast(attrs, [:movie_id, :actor_id])
    |> validate_required([:movie_id, :actor_id])
  end
end
