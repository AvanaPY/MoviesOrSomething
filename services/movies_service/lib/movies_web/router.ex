defmodule MoviesWeb.Router do
  use MoviesWeb, :router

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: %Ecto.NoResultsError{}, stack: _stack}) do
    send_resp(conn, conn.status, "No results found")
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: %Phoenix.Router.NoRouteError{}, stack: _stack}) do
    send_resp(conn, conn.status, "Nothing Found Here")
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MoviesWeb do
    pipe_through :api

    get "/", IndexController, :index

    get "/actors", ActorController, :index
    get "/actors/:id", ActorController, :show
    post "/actors/create", ActorController, :create
    post "/actors/update", ActorController, :update
    post "/actors/delete", ActorController, :delete

    get  "/movies", MovieController, :index
    get  "/movies/get/:id", MovieController, :show
    post "/movies/create", MovieController, :create
    post "/movies/update", MovieController, :update
    post "/movies/delete", MovieController, :delete

    get  "/movies/actors", MovieActorController, :index
    post "/movies/actors/create", MovieActorController, :create
    post "/movies/actors/delete", MovieActorController, :delete

    post "/movies/rating/rate", MovieRatingController, :create
    post "/movies/rating/update", MovieRatingController, :update
    post "/movies/rating/delete/:id", MovieRatingController, :delete

    post "/user/authenticate", UserController, :authenticate
    post "/user/create", UserController, :create
    post "/user/update", UserController, :update
    post "/user/delete", UserController, :delete

  end
end
