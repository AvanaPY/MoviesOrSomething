defmodule Movies.Actors.Actor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "actors" do
    field :name, :string
    field :last_name, :string
    field :age, :integer
    field :country, :string
    field :year_started, :integer
    field :year_ended, :integer
    has_many :movies_actors, Movies.MoviesActors.MovieActor
    # many_to_many :movies, Movies.Moviez.Movie, join_through: "movies_actors"

    timestamps()
  end

  @doc false
  def changeset(actor, attrs) do
    actor
    |> cast(attrs, [:name, :last_name, :age, :country, :year_started, :year_ended])
    |> validate_required([:name, :last_name, :age, :country, :year_started])
    |> validate_length(:name, greater_than: 2)
    |> validate_length(:last_name, greater_than: 2)
    |> validate_number(:age, greater_than: 0, less_than: 120)
    |> validate_number(:year_started, greater_than: 1900, less_than: 2024)
  end
end
