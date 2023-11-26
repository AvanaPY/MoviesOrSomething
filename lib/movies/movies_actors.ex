defmodule Movies.MoviesActors do
  @moduledoc """
  The MoviesActors context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.MoviesActors.MovieActor

  @doc """
  Returns the list of movies_actors.

  ## Examples

      iex> list_movies_actors()
      [%MovieActor{}, ...]

  """
  def list_movies_actors do
    Repo.all(MovieActor)
  end

  @doc """
  Gets a single movie_actor.

  Raises `Ecto.NoResultsError` if the Movie actor does not exist.

  ## Examples

      iex> get_movie_actor!(123)
      %MovieActor{}

      iex> get_movie_actor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie_actor!(id), do: Repo.get!(MovieActor, id)

  @doc """
  Creates a movie_actor.

  ## Examples

      iex> create_movie_actor(%{field: value})
      {:ok, %MovieActor{}}

      iex> create_movie_actor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie_actor(attrs \\ %{}) do
    %MovieActor{}
    |> MovieActor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movie_actor.

  ## Examples

      iex> update_movie_actor(movie_actor, %{field: new_value})
      {:ok, %MovieActor{}}

      iex> update_movie_actor(movie_actor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie_actor(%MovieActor{} = movie_actor, attrs) do
    movie_actor
    |> MovieActor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movie_actor.

  ## Examples

      iex> delete_movie_actor(movie_actor)
      {:ok, %MovieActor{}}

      iex> delete_movie_actor(movie_actor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie_actor(%MovieActor{} = movie_actor) do
    Repo.delete(movie_actor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie_actor changes.

  ## Examples

      iex> change_movie_actor(movie_actor)
      %Ecto.Changeset{data: %MovieActor{}}

  """
  def change_movie_actor(%MovieActor{} = movie_actor, attrs \\ %{}) do
    MovieActor.changeset(movie_actor, attrs)
  end
end
