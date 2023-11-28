defmodule MoviesWeb.MovieActorControllerTest do
  use MoviesWeb.ConnCase

  import Movies.MoviesActorsFixtures

  alias Movies.MoviesActors.MovieActor

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movies_actors", %{conn: conn} do
      conn = get(conn, Routes.movie_actor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movie_actor" do
    test "renders movie_actor when data is valid", %{conn: conn} do
      conn = post(conn, Routes.movie_actor_path(conn, :create), movie_actor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.movie_actor_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.movie_actor_path(conn, :create), movie_actor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movie_actor" do
    setup [:create_movie_actor]

    test "renders movie_actor when data is valid", %{conn: conn, movie_actor: %MovieActor{id: id} = movie_actor} do
      conn = put(conn, Routes.movie_actor_path(conn, :update, movie_actor), movie_actor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.movie_actor_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movie_actor: movie_actor} do
      conn = put(conn, Routes.movie_actor_path(conn, :update, movie_actor), movie_actor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movie_actor" do
    setup [:create_movie_actor]

    test "deletes chosen movie_actor", %{conn: conn, movie_actor: movie_actor} do
      conn = delete(conn, Routes.movie_actor_path(conn, :delete, movie_actor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.movie_actor_path(conn, :show, movie_actor))
      end
    end
  end

  defp create_movie_actor(_) do
    movie_actor = movie_actor_fixture()
    %{movie_actor: movie_actor}
  end
end
