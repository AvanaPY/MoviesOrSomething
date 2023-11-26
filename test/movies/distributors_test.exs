defmodule Movies.DistributorsTest do
  use Movies.DataCase

  alias Movies.Distributors

  describe "distributors" do
    alias Movies.Distributors.Distributor

    import Movies.DistributorsFixtures

    @invalid_attrs %{name: nil}

    test "list_distributors/0 returns all distributors" do
      distributor = distributor_fixture()
      assert Distributors.list_distributors() == [distributor]
    end

    test "get_distributor!/1 returns the distributor with given id" do
      distributor = distributor_fixture()
      assert Distributors.get_distributor!(distributor.id) == distributor
    end

    test "create_distributor/1 with valid data creates a distributor" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Distributor{} = distributor} = Distributors.create_distributor(valid_attrs)
      assert distributor.name == "some name"
    end

    test "create_distributor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Distributors.create_distributor(@invalid_attrs)
    end

    test "update_distributor/2 with valid data updates the distributor" do
      distributor = distributor_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Distributor{} = distributor} = Distributors.update_distributor(distributor, update_attrs)
      assert distributor.name == "some updated name"
    end

    test "update_distributor/2 with invalid data returns error changeset" do
      distributor = distributor_fixture()
      assert {:error, %Ecto.Changeset{}} = Distributors.update_distributor(distributor, @invalid_attrs)
      assert distributor == Distributors.get_distributor!(distributor.id)
    end

    test "delete_distributor/1 deletes the distributor" do
      distributor = distributor_fixture()
      assert {:ok, %Distributor{}} = Distributors.delete_distributor(distributor)
      assert_raise Ecto.NoResultsError, fn -> Distributors.get_distributor!(distributor.id) end
    end

    test "change_distributor/1 returns a distributor changeset" do
      distributor = distributor_fixture()
      assert %Ecto.Changeset{} = Distributors.change_distributor(distributor)
    end
  end
end
