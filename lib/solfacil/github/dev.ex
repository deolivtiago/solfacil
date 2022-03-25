defmodule Solfacil.Github.Dev do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devs" do
    field :username, :string
    field :name, :string
    field :avatar_url, :string
    field :location, :string
    field :bio, :string
    field :html_url, :string

    timestamps()
  end

  @doc false
  def changeset(dev, attrs) do
    dev
    |> cast(attrs, [:username, :avatar_url, :name, :location, :bio, :html_url])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end
end
