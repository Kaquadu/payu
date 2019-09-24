defmodule BookShop.Market.Book do
  # uses
  use BookShop.Schema

  @required_fields ~w(title author price condition_id shop_status_id)a
  @optional_fields ~w(transaction_id)a

  schema "books" do
    field :title,     :string,  null: false
    field :author,    :string,  null: false
    field :price,     :float,   null: false

    belongs_to :shop_status, BookShop.Market.ShopStatus, foreign_key: :shop_status_id
    belongs_to :transaction, BookShop.Payments.Transaction, foreign_key: :transaction_id
    belongs_to :condition, BookShop.Market.BookCondition, foreign_key: :condition_id

    timestamps()
  end

  def changeset(book, attrs \\ %{}) do
    book
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> cast_assoc(:condition)
    |> cast_assoc(:transaction)
    |> validate_required(@required_fields)
    |> validate_number(:price, greater_than: 0)
  end

end
