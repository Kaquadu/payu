defmodule BookShop.Payments.Transaction do
  # uses
  use BookShop.Schema

  schema "transactions" do
    field :price, :float, null: false
    field :description, :float

    belongs_to :state, BookShop.Payments.TransactionState, foreign_key: :transaction_state_id

    timestamps()
  end

end
