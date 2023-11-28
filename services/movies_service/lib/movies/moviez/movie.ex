defmodule Movies.Moviez.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :tagline, :string
    field :title, :string
    has_many :ratings, Movies.MovieRatings.MovieRating
    has_one :distributor, Movies.Distributors.Distributor
    has_many :movies_actors, Movies.MoviesActors.MovieActor
    # many_to_many :actors, Movies.Actors.Actor, join_through: "movies_actors"
    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :tagline])
    |> validate_required([:title, :tagline])
    |> unique_constraint(:title, message: "Title must be unique")
  end
end
