defmodule Movies.Actors.Actor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actors" do
    field :name, :string
    many_to_many :movies, Movies.Moviez.Movie, join_through: "movies_actors"

    timestamps()
  end

  @doc false
  def changeset(actor, attrs) do
    actor
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
