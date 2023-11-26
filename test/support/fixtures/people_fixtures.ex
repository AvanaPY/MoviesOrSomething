defmodule Movies.PeopleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.People` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Movies.People.create_person()

    person
  end
end
