defmodule BookShop.Payments.Transaction do
  # uses
  use BookShop.Schema

  @required_fields ~w(transaction_key price email f_name l_name street number zip_code city transaction_state_id)a
  @optional_fields ~w(description)a

  schema "transactions" do
    field :transaction_key, :string, null: false
    field :price, :float, null: false
    field :description, :float
    field :email, :string, null: false
    field :f_name, :string, null: false
    field :l_name, :string, null: false
    field :street, :string, null: false
    field :number, :string, null: false
    field :zip_code, :string, null: false
    field :city, :string, null: false

    belongs_to :state, BookShop.Payments.TransactionState, foreign_key: :transaction_state_id

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> cast_assoc(:state)
    |> validate_required(@required_fields)
  end
end
