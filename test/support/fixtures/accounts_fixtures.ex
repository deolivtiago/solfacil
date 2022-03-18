defmodule Solfacil.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Solfacil.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        admin: true,
        email: unique_user_email(),
        name: "some name",
        password: "some password"
      })
      |> Solfacil.Accounts.create_user()

    user
  end
end
