defmodule Movies.DistributorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Distributors` context.
  """

  @doc """
  Generate a distributor.
  """
  def distributor_fixture(attrs \\ %{}) do
    {:ok, distributor} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Movies.Distributors.create_distributor()

    distributor
  end
end
