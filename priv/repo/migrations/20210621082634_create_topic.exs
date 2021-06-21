defmodule Discuss.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topic) do
      add :title, :string

      timestamps()
    end

    create unique_index(:topic, [:title])
  end
end
