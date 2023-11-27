defmodule Movies.Repo.Migrations.CreateMoviesActors do
  use Ecto.Migration

  def change do
    create table(:movies_actors, primary_key: false) do
      add :movie_id, references(:movies, on_delete: :delete_all)
      add :actor_id, references(:actors, on_delete: :delete_all)
    end

    create index(:movies_actors, [:movie_id])
    create index(:movies_actors, [:actor_id])
  end
end
