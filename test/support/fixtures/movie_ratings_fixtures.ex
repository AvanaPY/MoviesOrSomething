defmodule Movies.MovieRatingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.MovieRatings` context.
  """

  @doc """
  Generate a movie_rating.
  """
  def movie_rating_fixture(attrs \\ %{}) do
    {:ok, movie_rating} =
      attrs
      |> Enum.into(%{
        rating: 120.5
      })
      |> Movies.MovieRatings.create_movie_rating()

    movie_rating
  end
end
