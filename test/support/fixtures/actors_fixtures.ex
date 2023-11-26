defmodule Movies.ActorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Actors` context.
  """

  @doc """
  Generate a actor.
  """
  def actor_fixture(attrs \\ %{}) do
    {:ok, actor} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Movies.Actors.create_actor()

    actor
  end
end
