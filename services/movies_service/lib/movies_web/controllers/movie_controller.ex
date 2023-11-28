defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller

  alias Movies.Moviez
  alias Movies.Moviez.Movie

  action_fallback MoviesWeb.FallbackController

  def index(%{params: %{"detailed" => "true"}} = conn, _params) do
    movies = Moviez.list_movies()

    movies =
      Enum.map(movies, fn m ->
        Movies.Repo.preload(m, [:distributor, :ratings, movies_actors: [:actor],])
      end)

    render(conn, "index.json", movies: movies)
  end

  def index(conn, _params) do
    movies = Moviez.list_movies()
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{"movie" => movie_params}) do
    with {_res, %Movie{} = movie} <- Moviez.create_movie(movie_params) do
      conn
      |> put_status(:created)
      |> render("show.json", movie: movie)
    end
  end

  def show(conn, %{"detailed" => "true", "id" => id}) do
    movie = Moviez.get_movie!(id, %{detailed: true})
    render(conn, "show.json", movie: movie)
  end

  def show(conn, %{"id" => id}) do
    movie = Moviez.get_movie!(id)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"movie" => movie_params}) do
    %{"title" => title} = movie_params

    movie =
      case Moviez.get_by_tile(title) do
        nil ->
          {:ok, m} = Moviez.create_movie(movie_params, %{preload: true})
          m

        movie ->
          {:ok, %Movie{} = movie} = Moviez.update_movie(movie, movie_params)
          movie
      end

    # Update distributor of a movie
    movie =
      with %{"distributor" => distributor_params} <- movie_params do
        if movie.distributor == nil do
          distrib =
            Ecto.build_assoc(movie, :distributor)
            |> Movies.Distributors.Distributor.changeset(distributor_params)
            |> Movies.Repo.insert!()

          Map.put(movie, :distributor, distrib)
        else
          distrib =
            movie.distributor
            |> Movies.Distributors.Distributor.changeset(distributor_params)
            |> Movies.Repo.update!()

          Map.put(movie, :distributor, distrib)
        end
      end

    # Distributor updated
    ##############################
    %{"actors" => actors_params} = movie_params
    {:ok, movie} = make_actor_associations(movie, actors_params)

    movie =
      Moviez.get_movie!(movie.id)
      |> Movies.Repo.preload([:distributor, :ratings, movies_actors: [:actor, :movie]])

    render(conn, "movie.json", %{movie: movie})
  end

  defp make_actor_associations(movie, actors_params) do
    Enum.each(actors_params, fn actor_params ->
      with actor <- Movies.Actors.create_or_get_by_name(actor_params),
           %{"role" => movies_actor_params} <- actor_params do
        case Movies.MoviesActors.get_movie_actor!(movie.id, actor.id) do
          nil ->
            Ecto.build_assoc(movie, :movies_actors)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:actor, actor)
            |> Movies.MoviesActors.MovieActor.changeset(movies_actor_params)
            |> Movies.Repo.insert!()

          ma ->
            ma
            |> Ecto.Changeset.change()
            |> Movies.MoviesActors.MovieActor.changeset(movies_actor_params)
            |> Movies.Repo.update!()
        end
      end
    end)

    # Reload it from the database
    # very bad but it is what it is. This isn't meant to be a good program
    # just a functional one at this stage.
    {:ok, movie}
  end

  def delete(conn, %{"id" => id}) do
    movie = Moviez.get_movie!(id)

    with {:ok, %Movie{}} <- Moviez.delete_movie(movie) do
      send_resp(conn, :no_content, "")
    end
  end
end
