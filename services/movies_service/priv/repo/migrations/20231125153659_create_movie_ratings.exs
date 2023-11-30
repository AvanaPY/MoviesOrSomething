defmodule Movies.Repo.Migrations.CreateMovieRatings do
  use Ecto.Migration

  def change do
    create table(:movie_ratings) do
      add :rating, :float
      add :movie_id, references(:movies, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :title, :string
      add :description, :text

      timestamps()
    end

    create index(:movie_ratings, [:movie_id, :user_id])
  end
end
