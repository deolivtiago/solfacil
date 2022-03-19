defmodule Solfacil.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Solfacil.Blog.Post

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :name, :string
    field :password, :string
    has_many :posts, Post, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :admin])
    |> validate_required([:name, :email, :password, :admin])
    |> unique_constraint(:email)
    |> validate_length(:name, min: 2, max: 150)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, max: 150)
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)
end
