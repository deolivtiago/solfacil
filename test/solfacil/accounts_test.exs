defmodule Solfacil.AccountsTest do
  use Solfacil.DataCase

  alias Solfacil.Accounts

  describe "users" do
    alias Solfacil.Accounts.User

    import Solfacil.AccountsFixtures

    @invalid_attrs %{admin: nil, email: nil, name: nil, password: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        admin: true,
        email: "some_email@mail.com",
        name: "some name",
        password: "some_password"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.admin == true
      assert user.email == "some_email@mail.com"
      assert user.name == "some name"
      assert user.password == "some_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        admin: false,
        email: "some_updated_email@mail.com",
        name: "some updated name",
        password: "some_updated_password"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.admin == false
      assert user.email == "some_updated_email@mail.com"
      assert user.name == "some updated name"
      assert user.password == "some_updated_password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
