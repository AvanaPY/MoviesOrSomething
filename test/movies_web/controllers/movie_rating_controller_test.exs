defmodule MoviesWeb.MovieRatingControllerTest do
  use MoviesWeb.ConnCase

  import Movies.MovieRatingsFixtures

  alias Movies.MovieRatings.MovieRating

  @create_attrs %{
    rating: 120.5
  }
  @update_attrs %{
    rating: 456.7
  }
  @invalid_attrs %{rating: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movie_ratings", %{conn: conn} do
      conn = get(conn, Routes.movie_rating_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movie_rating" do
    test "renders movie_rating when data is valid", %{conn: conn} do
      conn = post(conn, Routes.movie_rating_path(conn, :create), movie_rating: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.movie_rating_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "rating" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.movie_rating_path(conn, :create), movie_rating: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movie_rating" do
    setup [:create_movie_rating]

    test "renders movie_rating when data is valid", %{conn: conn, movie_rating: %MovieRating{id: id} = movie_rating} do
      conn = put(conn, Routes.movie_rating_path(conn, :update, movie_rating), movie_rating: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.movie_rating_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "rating" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movie_rating: movie_rating} do
      conn = put(conn, Routes.movie_rating_path(conn, :update, movie_rating), movie_rating: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movie_rating" do
    setup [:create_movie_rating]

    test "deletes chosen movie_rating", %{conn: conn, movie_rating: movie_rating} do
      conn = delete(conn, Routes.movie_rating_path(conn, :delete, movie_rating))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.movie_rating_path(conn, :show, movie_rating))
      end
    end
  end

  defp create_movie_rating(_) do
    movie_rating = movie_rating_fixture()
    %{movie_rating: movie_rating}
  end
end
