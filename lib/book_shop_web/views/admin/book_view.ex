defmodule BookShopWeb.Admin.BookView do
  # uses
  use BookShopWeb, :view
  # aliases
  alias BookShop.Market

  def get_book_conditions_list() do
    Market.get_all_book_conditions()
    |> Enum.map(fn %{name: k, id: v} ->
      [key: k, value: v]
    end)
  end
end
