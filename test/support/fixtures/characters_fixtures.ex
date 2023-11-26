defmodule Movies.CharactersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Characters` context.
  """

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Movies.Characters.create_character()

    character
  end
end
