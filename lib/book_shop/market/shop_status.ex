defmodule BookShop.Market.ShopStatus do
  # uses
  use BookShop.Schema

  @required_fields ~w(name)a

  schema "shop_statuses" do
    field :name, :string, null: false

    timestamps()
  end

  def changeset(status, attrs \\ %{}) do
    status
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end

end
