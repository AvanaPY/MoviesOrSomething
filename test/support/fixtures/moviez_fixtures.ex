defmodule Movies.MoviezFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Moviez` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        tagline: "some tagline",
        title: "some title"
      })
      |> Movies.Moviez.create_movie()

    movie
  end
end
