defmodule Movies.MovieRatings.MovieRating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movie_ratings" do
    field :rating, :float
    field :title, :string
    field :description, :string
    belongs_to :user, Movies.Users.User
    belongs_to :movie, Movies.Moviez.Movie

    timestamps()
  end

  @doc false
  def changeset(movie_rating, attrs) do
    movie_rating
    |> cast(attrs, [:rating, :movie_id, :user_id, :title, :description])
    |> validate_required([:rating, :movie_id, :user_id, :title, :description])
    |> validate_number(:rating, greater_than_or_equal_to: 0)
    |> validate_number(:rating, less_than_or_equal_to: 10)
    |> validate_length(:title, min: 1)
    |> validate_length(:description, min: 1)
  end
end
