defmodule Solfacil.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Solfacil.Blog` context.
  """
  import Solfacil.AccountsFixtures
  alias Solfacil.Repo

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title",
        author_id: user.id
      })
      |> Solfacil.Blog.create_post()

    post
    |> Repo.preload(:author)
  end
end
