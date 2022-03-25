defmodule Solfacil.Repo.Migrations.CreateDevs do
  use Ecto.Migration

  def change do
    create table(:devs) do
      add :username, :string, null: false
      add :avatar_url, :string, null: false
      add :name, :string, null: false
      add :location, :string
      add :bio, :string
      add :html_url, :string, null: false

      timestamps()
    end

    create unique_index(:devs, [:username])
  end
end
