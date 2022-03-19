defmodule Solfacil.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Solfacil.Accounts.User

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :author, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :author_id])
    |> validate_required([:title, :content, :author_id])
    |> validate_length(:title, min: 3, max: 150)
    |> validate_length(:content, min: 3)
    |> assoc_constraint(:author)
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)
end
