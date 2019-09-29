defmodule BookShop.Repo.Migrations.AddDeliveryDataToTransactions do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :transaction_key, :string, null: false
      add :email, :string, null: false
      add :f_name, :string, null: false
      add :l_name, :string, null: false
      add :street, :string, null: false
      add :number, :string, null: false
      add :zip_code, :string, null: false
      add :city, :string, null: false
    end
  end
end
