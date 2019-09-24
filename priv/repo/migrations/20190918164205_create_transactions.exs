defmodule BookShop.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :price, :float, null: false
      add :description, :string
      add :transaction_state_id, references(:transaction_states), null: false

      timestamps()
    end
  end
end
