defmodule Movies.MoviesActorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.MoviesActors` context.
  """

  @doc """
  Generate a movie_actor.
  """
  def movie_actor_fixture(attrs \\ %{}) do
    {:ok, movie_actor} =
      attrs
      |> Enum.into(%{

      })
      |> Movies.MoviesActors.create_movie_actor()

    movie_actor
  end
end
