defmodule Movies.People.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :name, :string
    field :age, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
