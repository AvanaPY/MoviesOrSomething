defmodule MoviesWeb.Router do
  use MoviesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MoviesWeb do
    pipe_through :api

    get "/", IndexController, :index

    get "/actors", ActorController, :index
    post "/actors/create", ActorController, :create

    get  "/movies", MovieController, :index
    get "/movies/get/:id", MovieController, :show
    post "/movies/create", MovieController, :create
    post "/movies/delete", MovieController, :delete
    post "/movies/update", MovieController, :update

    post "/movies/rate", MovieRatingController, :create
  end
end
