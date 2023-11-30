defmodule Movies.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        username: "some username"
      })
      |> Movies.Users.create_user()

    user
  end
end
