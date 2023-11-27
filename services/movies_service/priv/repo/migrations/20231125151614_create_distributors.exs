defmodule Movies.Repo.Migrations.CreateDistributors do
  use Ecto.Migration

  def change do
    create table(:distributors) do
      add :name, :string
      add :movie_id, references(:movies, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:distributors, [:movie_id])
  end
end
