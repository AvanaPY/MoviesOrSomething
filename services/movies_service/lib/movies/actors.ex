defmodule Movies.Actors do
  @moduledoc """
  The Actors context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.Actors.Actor

  @doc """
  Returns the list of actors.

  ## Examples

      iex> list_actors()
      [%Actor{}, ...]

  """
  def list_actors do
    Repo.all(Actor)
  end

  @doc """
  Gets a single actor.

  Raises `Ecto.NoResultsError` if the Actor does not exist.

  ## Examples

      iex> get_actor!(123)
      %Actor{}

      iex> get_actor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_actor!(id), do: Repo.get!(Actor, id)

  def get_by_full_name(fullname) do
    names = String.split(fullname, " ")
    case names do
      [name, last_name] ->
        case Repo.get_by(Actor, name: name, last_name: last_name) do
          nil -> {:error, :not_found}
          actor -> {:ok, actor}
        end
      _ -> {:error, :invalid_format}
    end
  end

  @doc """
  Creates or gets a single actor from the database if it doesn't exist

  ## Examples

      iex> create_or_get_by_name(%{name: "ActorThatExists"})
      %Actor{}
      iex> create_or_get_by_name(%{name: "ActorThatDoesNotExist"})
      %Actor{}
  """
  def create_or_get_by_name(%{"name" => name} = attrs) do
    case Repo.get_by(Actor, name: name) do
      nil ->
        with {:ok, actor} <- create_actor(attrs) do
          actor
        end

      actor ->
        actor
    end
  end

  @doc """
  Creates a actor.

  ## Examples

      iex> create_actor(%{field: value})
      {:ok, %Actor{}}

      iex> create_actor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_actor(attrs \\ %{}) do
    %Actor{}
    |> Actor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a actor.

  ## Examples

      iex> update_actor(actor, %{field: new_value})
      {:ok, %Actor{}}

      iex> update_actor(actor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_actor(%Actor{} = actor, attrs) do
    actor
    |> Actor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a actor.

  ## Examples

      iex> delete_actor(actor)
      {:ok, %Actor{}}

      iex> delete_actor(actor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_actor(%Actor{} = actor) do
    Repo.delete(actor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking actor changes.

  ## Examples

      iex> change_actor(actor)
      %Ecto.Changeset{data: %Actor{}}

  """
  def change_actor(%Actor{} = actor, attrs \\ %{}) do
    Actor.changeset(actor, attrs)
  end
end
