defmodule Solfacil.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, size: 150, null: false
      add :email, :string, size: 150, null: false
      add :password, :string, null: false
      add :admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
