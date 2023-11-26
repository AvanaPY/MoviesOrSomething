defmodule MoviesWeb.Router do
  use MoviesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MoviesWeb do
    pipe_through :api

    get "/actors", ActorController, :index
    post "/actors/create", ActorController, :create

    get "/movies", MovieController, :index
    post "/movies/create", MovieController, :create
    post "/movies/delete", MovieController, :delete
    post "/movies/update", MovieController, :update
  end
end
