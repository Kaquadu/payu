defmodule BookShop.Repo.Migrations.CreateBookConditions do
  use Ecto.Migration

  def change do
    create table(:book_conditions) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:book_conditions, :name)
  end
end
