defmodule MoviesWeb.IndexController do
  use MoviesWeb, :controller

  def index(conn, _params) do
    text conn, "Hello World!"
  end
end
