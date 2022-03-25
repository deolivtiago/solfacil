defmodule Solfacil.GithubFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Solfacil.Github` context.
  """

  @doc """
  Generate a unique dev username.
  """
  def unique_dev_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a dev.
  """
  def dev_fixture(attrs \\ %{}) do
    {:ok, dev} =
      attrs
      |> Enum.into(%{
        avatar_url: "some avatar_url",
        bio: "some bio",
        location: "some location",
        name: "some name",
        repos_url: "some repos_url",
        username: unique_dev_username()
      })
      |> Solfacil.Github.create_dev()

    dev
  end
end
