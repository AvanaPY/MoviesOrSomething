defmodule MoviesWeb.DistributorController do
  use MoviesWeb, :controller

  alias Movies.Distributors
  alias Movies.Distributors.Distributor

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    distributors = Distributors.list_distributors()
    render(conn, "index.json", distributors: distributors)
  end

  def create(conn, %{"distributor" => distributor_params}) do
    with {:ok, %Distributor{} = distributor} <- Distributors.create_distributor(distributor_params) do
      conn
      |> put_status(:created)
      |> render("show.json", distributor: distributor)
    end
  end

  def show(conn, %{"id" => id}) do
    distributor = Distributors.get_distributor!(id)
    render(conn, "show.json", distributor: distributor)
  end

  def update(conn, %{"id" => id, "distributor" => distributor_params}) do
    distributor = Distributors.get_distributor!(id)

    with {:ok, %Distributor{} = distributor} <- Distributors.update_distributor(distributor, distributor_params) do
      render(conn, "show.json", distributor: distributor)
    end
  end

  def delete(conn, %{"id" => id}) do
    distributor = Distributors.get_distributor!(id)

    with {:ok, %Distributor{}} <- Distributors.delete_distributor(distributor) do
      send_resp(conn, :no_content, "")
    end
  end
end
