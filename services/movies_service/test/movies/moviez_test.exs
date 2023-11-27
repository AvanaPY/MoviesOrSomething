defmodule Movies.MoviezTest do
  use Movies.DataCase

  alias Movies.Moviez

  describe "movies" do
    alias Movies.Moviez.Movie

    import Movies.MoviezFixtures

    @invalid_attrs %{}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Moviez.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Moviez.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{}

      assert {:ok, %Movie{} = movie} = Moviez.create_movie(valid_attrs)
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Moviez.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{}

      assert {:ok, %Movie{} = movie} = Moviez.update_movie(movie, update_attrs)
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Moviez.update_movie(movie, @invalid_attrs)
      assert movie == Moviez.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Moviez.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Moviez.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Moviez.change_movie(movie)
    end
  end

  describe "movies" do
    alias Movies.Moviez.Movie

    import Movies.MoviezFixtures

    @invalid_attrs %{tagline: nil, title: nil}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Moviez.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Moviez.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{tagline: "some tagline", title: "some title"}

      assert {:ok, %Movie{} = movie} = Moviez.create_movie(valid_attrs)
      assert movie.tagline == "some tagline"
      assert movie.title == "some title"
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Moviez.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{tagline: "some updated tagline", title: "some updated title"}

      assert {:ok, %Movie{} = movie} = Moviez.update_movie(movie, update_attrs)
      assert movie.tagline == "some updated tagline"
      assert movie.title == "some updated title"
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Moviez.update_movie(movie, @invalid_attrs)
      assert movie == Moviez.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Moviez.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Moviez.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Moviez.change_movie(movie)
    end
  end
end
