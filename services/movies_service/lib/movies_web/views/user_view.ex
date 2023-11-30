defmodule MoviesWeb.UserView do
  use MoviesWeb, :view
  alias MoviesWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      username: user.username,
      token: user.username
    }
  end
end
