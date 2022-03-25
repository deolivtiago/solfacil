defmodule Solfacil.GithubTest do
  use Solfacil.DataCase

  alias Solfacil.Github

  describe "devs" do
    alias Solfacil.Github.Dev

    import Solfacil.GithubFixtures

    @invalid_attrs %{avatar_url: nil, bio: nil, location: nil, name: nil, repos_url: nil, username: nil}

    test "list_devs/0 returns all devs" do
      dev = dev_fixture()
      assert Github.list_devs() == [dev]
    end

    test "get_dev!/1 returns the dev with given id" do
      dev = dev_fixture()
      assert Github.get_dev!(dev.id) == dev
    end

    test "create_dev/1 with valid data creates a dev" do
      valid_attrs = %{avatar_url: "some avatar_url", bio: "some bio", location: "some location", name: "some name", repos_url: "some repos_url", username: "some username"}

      assert {:ok, %Dev{} = dev} = Github.create_dev(valid_attrs)
      assert dev.avatar_url == "some avatar_url"
      assert dev.bio == "some bio"
      assert dev.location == "some location"
      assert dev.name == "some name"
      assert dev.repos_url == "some repos_url"
      assert dev.username == "some username"
    end

    test "create_dev/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Github.create_dev(@invalid_attrs)
    end

    test "update_dev/2 with valid data updates the dev" do
      dev = dev_fixture()
      update_attrs = %{avatar_url: "some updated avatar_url", bio: "some updated bio", location: "some updated location", name: "some updated name", repos_url: "some updated repos_url", username: "some updated username"}

      assert {:ok, %Dev{} = dev} = Github.update_dev(dev, update_attrs)
      assert dev.avatar_url == "some updated avatar_url"
      assert dev.bio == "some updated bio"
      assert dev.location == "some updated location"
      assert dev.name == "some updated name"
      assert dev.repos_url == "some updated repos_url"
      assert dev.username == "some updated username"
    end

    test "update_dev/2 with invalid data returns error changeset" do
      dev = dev_fixture()
      assert {:error, %Ecto.Changeset{}} = Github.update_dev(dev, @invalid_attrs)
      assert dev == Github.get_dev!(dev.id)
    end

    test "delete_dev/1 deletes the dev" do
      dev = dev_fixture()
      assert {:ok, %Dev{}} = Github.delete_dev(dev)
      assert_raise Ecto.NoResultsError, fn -> Github.get_dev!(dev.id) end
    end

    test "change_dev/1 returns a dev changeset" do
      dev = dev_fixture()
      assert %Ecto.Changeset{} = Github.change_dev(dev)
    end
  end
end
