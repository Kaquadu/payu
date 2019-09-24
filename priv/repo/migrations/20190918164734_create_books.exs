defmodule BookShop.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :author, :string, null: false
      add :price, :float, null: false
      add :transaction_id, references(:transactions)
      add :condition_id, references(:book_conditions)

      timestamps()
    end
  end
end
