defmodule BookShop.Payments.TransactionState do
  # uses
  use BookShop.Schema

  schema "transaction_states" do
    field :name, :string, null: false

    timestamps()
  end

end
