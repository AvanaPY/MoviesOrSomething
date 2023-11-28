defmodule Movies.MovieRatings do
  @moduledoc """
  The MovieRatings context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.MovieRatings.MovieRating

  @doc """
  Returns the list of movie_ratings.

  ## Examples

      iex> list_movie_ratings()
      [%MovieRating{}, ...]

  """
  def list_movie_ratings do
    Repo.all(MovieRating)
  end

  @doc """
  Gets a single movie_rating.

  Raises `Ecto.NoResultsError` if the Movie rating does not exist.

  ## Examples

      iex> get_movie_rating!(123)
      %MovieRating{}

      iex> get_movie_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie_rating!(id), do: Repo.get!(MovieRating, id)

  @doc """
  Creates a movie_rating.

  ## Examples

      iex> create_movie_rating(%{field: value})
      {:ok, %MovieRating{}}

      iex> create_movie_rating(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie_rating(attrs \\ %{}) do
    %MovieRating{}
    |> MovieRating.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movie_rating.

  ## Examples

      iex> update_movie_rating(movie_rating, %{field: new_value})
      {:ok, %MovieRating{}}

      iex> update_movie_rating(movie_rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie_rating(%MovieRating{} = movie_rating, attrs) do
    movie_rating
    |> MovieRating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movie_rating.

  ## Examples

      iex> delete_movie_rating(movie_rating)
      {:ok, %MovieRating{}}

      iex> delete_movie_rating(movie_rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie_rating(%MovieRating{} = movie_rating) do
    Repo.delete(movie_rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie_rating changes.

  ## Examples

      iex> change_movie_rating(movie_rating)
      %Ecto.Changeset{data: %MovieRating{}}

  """
  def change_movie_rating(%MovieRating{} = movie_rating, attrs \\ %{}) do
    MovieRating.changeset(movie_rating, attrs)
  end
end
