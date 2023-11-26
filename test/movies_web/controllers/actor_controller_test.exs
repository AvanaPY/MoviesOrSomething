defmodule MoviesWeb.ActorControllerTest do
  use MoviesWeb.ConnCase

  import Movies.ActorsFixtures

  alias Movies.Actors.Actor

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
    test "lists all actors", %{conn: conn} do
      conn = get(conn, Routes.actor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create actor" do
    test "renders actor when data is valid", %{conn: conn} do
      conn = post(conn, Routes.actor_path(conn, :create), actor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.actor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.actor_path(conn, :create), actor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update actor" do
    setup [:create_actor]

    test "renders actor when data is valid", %{conn: conn, actor: %Actor{id: id} = actor} do
      conn = put(conn, Routes.actor_path(conn, :update, actor), actor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.actor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, actor: actor} do
      conn = put(conn, Routes.actor_path(conn, :update, actor), actor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete actor" do
    setup [:create_actor]

    test "deletes chosen actor", %{conn: conn, actor: actor} do
      conn = delete(conn, Routes.actor_path(conn, :delete, actor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.actor_path(conn, :show, actor))
      end
    end
  end

  defp create_actor(_) do
    actor = actor_fixture()
    %{actor: actor}
  end
end
