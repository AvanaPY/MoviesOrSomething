defmodule Movies.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :tagline, :string
      add :release_year, :integer
      add :director, :string
      add :length_minutes, :integer
      add :language, :string
      add :budget, :integer
      add :box_office, :integer

      timestamps()
    end
    create unique_index(:movies, [:title])
    create index(:movies, [:director, :language, :release_year])
  end
end
