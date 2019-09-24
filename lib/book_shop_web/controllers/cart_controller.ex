defmodule BookShopWeb.CartController do
  # uses
  use BookShopWeb, :controller
  # aliases
  alias BookShop.Market

  def index(conn, _params) do 
    cart_ids = conn |> get_session(:cart)
    case cart_ids do
      nil ->
        render(conn, "index.html", books: [], full_price: 0)
      _-> 
        books = Market.get_books_by_id_list(cart_ids)
        full_price = Enum.reduce(books, 0, fn b, acc -> b.price + acc end)
        render(conn, "index.html", books: books, full_price: full_price)
      end
  end

  def add_to_cart(conn, %{"id" => id}) do
    conn
    |> assign_new_to_cart(id)
    |> redirect(to: NavigationHistory.last_path(conn))
  end
  
  def remove_from_cart(conn, %{"id" => id}) do
    conn 
    |> remove_item_from_cart(id)
    |> redirect(to: NavigationHistory.last_path(conn))
  end

  defp remove_item_from_cart(conn, id) do
    new_cart = conn |> get_session(:cart) |> decrement_map(id)
    conn |> put_session(:cart, new_cart)
  end

  defp assign_new_to_cart(conn, id) do
    new_cart = conn |> get_session(:cart) |> increment_map(id)
    conn |> put_session(:cart, new_cart)
  end

  defp increment_map(nil, key) do
    %{key => 1}
  end

  defp increment_map(map, key) do
    Map.update(map, key, 1, fn x -> x+1 end)
  end

  def decrement_map(map, key) do
    map = Map.update!(map, key, fn x -> x-1 end)
    case Map.get(map, key) do
      0 -> Map.delete(map, key)
      _ -> map
    end
  end
end
