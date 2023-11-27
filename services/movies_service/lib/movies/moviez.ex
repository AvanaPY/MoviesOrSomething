defmodule Movies.Moviez do
  @moduledoc """
  The Moviez context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.Moviez.Movie

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movie{}, ...]

  """
  def list_movies do
    Repo.all(Movie)
  end

  @doc """
  Gets a single movie.

  Raises `Ecto.NoResultsError` if the Movie does not exist.

  ## Examples

      iex> get_movie!(123)
      %Movie{}

      iex> get_movie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie!(id, %{detailed: true}), do: get_movie!(id) |> Repo.preload([:actors, :distributor, :ratings])
  def get_movie!(id), do: Repo.get!(Movie, id)

  def get_by_tile(title), do: Repo.get_by(Movie, title: title) |> Repo.preload([:actors, :distributor, :ratings])
  @doc """
  Creates a movie.

  ## Examples

      iex> create_movie(%{field: value})
      {:ok, %Movie{}}

      iex> create_movie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie(attrs \\ %{}) do
    with {:ok, m} <- %Movie{} |> Movie.changeset(attrs) |> Repo.insert() do
      {:ok, m}
    end
  end

  def create_movie(attrs, %{preload: true}) do
    with {:ok, m} <- %Movie{} |> Movie.changeset(attrs) |> Repo.insert() do
      {:ok, m |> Repo.preload([:actors, :distributor, :ratings])}
    end
  end

  def create_or_get_movie(%{"title" => title} = attrs) do
    case Repo.get_by(Movie, title: title) do
      nil -> {:created, create_movie(attrs)}
      movie -> {:exists, movie}
    end
  end

  @doc """
  Updates a movie.

  ## Examples

      iex> update_movie(movie, %{field: new_value})
      {:ok, %Movie{}}

      iex> update_movie(movie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie(%Movie{} = movie, attrs) do
    movie
    |> Movie.changeset(attrs)
    |> Repo.update()
  end

  def update_movie(%Movie{} = movie, actors, distributor_attrs, attrs) do
    IO.inspect movie
    if movie.distributor == nil do
      distrib = movie
      |> Ecto.build_assoc(:distributor, distributor_attrs)
      # |> Movies.Distributors.Distributor.changeset(distributor_attrs)
      |> Repo.insert!

      IO.inspect distrib
    else
      Movies.Distributors.update_distributor(movie.distributor, distributor_attrs)
    end

    actors = Enum.map(actors, fn a -> Movies.Actors.create_or_get_by_name(a) end)
    movie
    |> Movie.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:actors, actors)
    |> IO.inspect
    |> Repo.update()
  end

  @doc """
  Deletes a movie.

  ## Examples

      iex> delete_movie(movie)
      {:ok, %Movie{}}

      iex> delete_movie(movie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie(%Movie{} = movie) do
    Repo.delete(movie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie changes.

  ## Examples

      iex> change_movie(movie)
      %Ecto.Changeset{data: %Movie{}}

  """
  def change_movie(%Movie{} = movie, attrs \\ %{}) do
    Movie.changeset(movie, attrs)
  end
end
