defmodule Movies.Repo.Migrations.AddIndexToUser do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:username])
  end
end
