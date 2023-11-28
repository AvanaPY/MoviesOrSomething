defmodule Movies.Moviez.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :tagline, :string
    field :title, :string
    field :release_year, :integer
    field :director, :string
    field :length_minutes, :integer
    field :language, :string
    field :budget, :integer
    field :box_office, :integer
    has_many :ratings, Movies.MovieRatings.MovieRating
    has_one :distributor, Movies.Distributors.Distributor
    has_many :movies_actors, Movies.MoviesActors.MovieActor
    # many_to_many :actors, Movies.Actors.Actor, join_through: "movies_actors"
    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :tagline, :release_year, :director, :length_minutes, :language, :budget, :box_office])
    |> validate_required([:title, :tagline, :release_year, :director, :length_minutes, :language, :budget])
    |> unique_constraint(:title, message: "Title must be unique")
    |> validate_length(:title, min: 2)
    |> validate_length(:director, min: 2)
    |> validate_length(:language, min: 2, max: 3)
    |> validate_number(:release_year, greater_than: 1900, less_than: 2024)
    |> validate_number(:length_minutes, greater_than: 1)
    |> validate_number(:budget, greater_than: 0)
    |> validate_number(:box_office, greater_than: 0)
  end
end
