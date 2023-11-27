defmodule MoviesWeb.DistributorControllerTest do
  use MoviesWeb.ConnCase

  import Movies.DistributorsFixtures

  alias Movies.Distributors.Distributor

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all distributors", %{conn: conn} do
      conn = get(conn, Routes.distributor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create distributor" do
    test "renders distributor when data is valid", %{conn: conn} do
      conn = post(conn, Routes.distributor_path(conn, :create), distributor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.distributor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.distributor_path(conn, :create), distributor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update distributor" do
    setup [:create_distributor]

    test "renders distributor when data is valid", %{conn: conn, distributor: %Distributor{id: id} = distributor} do
      conn = put(conn, Routes.distributor_path(conn, :update, distributor), distributor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.distributor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, distributor: distributor} do
      conn = put(conn, Routes.distributor_path(conn, :update, distributor), distributor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete distributor" do
    setup [:create_distributor]

    test "deletes chosen distributor", %{conn: conn, distributor: distributor} do
      conn = delete(conn, Routes.distributor_path(conn, :delete, distributor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.distributor_path(conn, :show, distributor))
      end
    end
  end

  defp create_distributor(_) do
    distributor = distributor_fixture()
    %{distributor: distributor}
  end
end
