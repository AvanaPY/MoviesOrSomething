defmodule Movies.MoviesActorsTest do
  use Movies.DataCase

  alias Movies.MoviesActors

  describe "movies_actors" do
    alias Movies.MoviesActors.MovieActor

    import Movies.MoviesActorsFixtures

    @invalid_attrs %{}

    test "list_movies_actors/0 returns all movies_actors" do
      movie_actor = movie_actor_fixture()
      assert MoviesActors.list_movies_actors() == [movie_actor]
    end

    test "get_movie_actor!/1 returns the movie_actor with given id" do
      movie_actor = movie_actor_fixture()
      assert MoviesActors.get_movie_actor!(movie_actor.id) == movie_actor
    end

    test "create_movie_actor/1 with valid data creates a movie_actor" do
      valid_attrs = %{}

      assert {:ok, %MovieActor{} = movie_actor} = MoviesActors.create_movie_actor(valid_attrs)
    end

    test "create_movie_actor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoviesActors.create_movie_actor(@invalid_attrs)
    end

    test "update_movie_actor/2 with valid data updates the movie_actor" do
      movie_actor = movie_actor_fixture()
      update_attrs = %{}

      assert {:ok, %MovieActor{} = movie_actor} = MoviesActors.update_movie_actor(movie_actor, update_attrs)
    end

    test "update_movie_actor/2 with invalid data returns error changeset" do
      movie_actor = movie_actor_fixture()
      assert {:error, %Ecto.Changeset{}} = MoviesActors.update_movie_actor(movie_actor, @invalid_attrs)
      assert movie_actor == MoviesActors.get_movie_actor!(movie_actor.id)
    end

    test "delete_movie_actor/1 deletes the movie_actor" do
      movie_actor = movie_actor_fixture()
      assert {:ok, %MovieActor{}} = MoviesActors.delete_movie_actor(movie_actor)
      assert_raise Ecto.NoResultsError, fn -> MoviesActors.get_movie_actor!(movie_actor.id) end
    end

    test "change_movie_actor/1 returns a movie_actor changeset" do
      movie_actor = movie_actor_fixture()
      assert %Ecto.Changeset{} = MoviesActors.change_movie_actor(movie_actor)
    end
  end
end
