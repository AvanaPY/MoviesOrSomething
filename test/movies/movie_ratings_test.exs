defmodule Movies.MovieRatingsTest do
  use Movies.DataCase

  alias Movies.MovieRatings

  describe "movie_ratings" do
    alias Movies.MovieRatings.MovieRating

    import Movies.MovieRatingsFixtures

    @invalid_attrs %{rating: nil}

    test "list_movie_ratings/0 returns all movie_ratings" do
      movie_rating = movie_rating_fixture()
      assert MovieRatings.list_movie_ratings() == [movie_rating]
    end

    test "get_movie_rating!/1 returns the movie_rating with given id" do
      movie_rating = movie_rating_fixture()
      assert MovieRatings.get_movie_rating!(movie_rating.id) == movie_rating
    end

    test "create_movie_rating/1 with valid data creates a movie_rating" do
      valid_attrs = %{rating: 120.5}

      assert {:ok, %MovieRating{} = movie_rating} = MovieRatings.create_movie_rating(valid_attrs)
      assert movie_rating.rating == 120.5
    end

    test "create_movie_rating/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MovieRatings.create_movie_rating(@invalid_attrs)
    end

    test "update_movie_rating/2 with valid data updates the movie_rating" do
      movie_rating = movie_rating_fixture()
      update_attrs = %{rating: 456.7}

      assert {:ok, %MovieRating{} = movie_rating} = MovieRatings.update_movie_rating(movie_rating, update_attrs)
      assert movie_rating.rating == 456.7
    end

    test "update_movie_rating/2 with invalid data returns error changeset" do
      movie_rating = movie_rating_fixture()
      assert {:error, %Ecto.Changeset{}} = MovieRatings.update_movie_rating(movie_rating, @invalid_attrs)
      assert movie_rating == MovieRatings.get_movie_rating!(movie_rating.id)
    end

    test "delete_movie_rating/1 deletes the movie_rating" do
      movie_rating = movie_rating_fixture()
      assert {:ok, %MovieRating{}} = MovieRatings.delete_movie_rating(movie_rating)
      assert_raise Ecto.NoResultsError, fn -> MovieRatings.get_movie_rating!(movie_rating.id) end
    end

    test "change_movie_rating/1 returns a movie_rating changeset" do
      movie_rating = movie_rating_fixture()
      assert %Ecto.Changeset{} = MovieRatings.change_movie_rating(movie_rating)
    end
  end
end
