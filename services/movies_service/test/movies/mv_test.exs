defmodule Movies.MVTest do
  use Movies.DataCase

  alias Movies.MV

  describe "persons" do
    alias Movies.MV.Person

    import Movies.MVFixtures

    @invalid_attrs %{}

    test "list_persons/0 returns all persons" do
      person = person_fixture()
      assert MV.list_persons() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert MV.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      valid_attrs = %{}

      assert {:ok, %Person{} = person} = MV.create_person(valid_attrs)
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MV.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      update_attrs = %{}

      assert {:ok, %Person{} = person} = MV.update_person(person, update_attrs)
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = MV.update_person(person, @invalid_attrs)
      assert person == MV.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = MV.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> MV.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = MV.change_person(person)
    end
  end
end
