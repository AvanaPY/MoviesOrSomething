defmodule Movies.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :movie_id, references(:movies, on_delete: :nothing)

      timestamps()
    end

    create index(:characters, [:movie_id])
  end
end
