defmodule Solfacil.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, size: 150, null: false
      add :content, :string, null: false
      add :author_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:posts, [:author_id])
  end
end
