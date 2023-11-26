defmodule Movies.MVFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.MV` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{

      })
      |> Movies.MV.create_person()

    person
  end
end
