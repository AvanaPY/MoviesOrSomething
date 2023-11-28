defmodule Movies.Repo.Migrations.CreateActors do
  use Ecto.Migration

  def change do
    create table(:actors) do
      add :name, :string
      add :last_name, :string
      add :age, :integer
      add :country, :string
      add :year_started, :integer
      add :year_ended, :integer

      timestamps()
    end

    create unique_index(:actors, [:name])
  end
end
