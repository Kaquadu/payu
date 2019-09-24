defmodule BookShop.Market.BookCondition do
  # uses
  use BookShop.Schema

  @required_fields ~w(name)a

  schema "book_conditions" do
    field :name, :string, null: false

    timestamps()
  end

  def changeset(condition, attrs \\ %{}) do
    condition
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end

end
