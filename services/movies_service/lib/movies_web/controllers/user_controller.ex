defmodule MoviesWeb.UserController do
  use MoviesWeb, :controller

  alias Movies.Users
  alias Movies.Users.User

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    try do
      with {:ok, %User{} = user} <- Users.create_user(user_params) do
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      end
    rescue
      Ecto.ConstraintError ->
        conn
        |> send_resp(409, "Username already exists")
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def authenticate(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Users.get_by_username(username) do
      case user.password do
        ^password ->
          conn
          |> render("show.json", user: user)

        _ ->
          conn
          |> send_resp(404, "Unauthorized")
      end
    end
  end
end
