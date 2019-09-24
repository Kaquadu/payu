defmodule BookShop.Repo.Migrations.CreateTransactionStates do
  use Ecto.Migration

  def change do
    create table(:transaction_states) do
      add :name, :string

      timestamps()
    end

    create unique_index(:transaction_states, :name)
  end
end
