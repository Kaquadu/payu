defmodule BookShopWeb.CartController do
  # uses
  use BookShopWeb, :controller
  # aliases
  alias BookShop.Market
  alias BookShopWeb.Payu

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

  def summary(conn, _params) do
    cart_ids = conn |> get_session(:cart)
    case cart_ids do
      nil ->
        render(conn, "index.html", books: [], full_price: 0)
      _-> 
        books = Market.get_books_by_id_list(cart_ids)
        full_price = Enum.reduce(books, 0, fn b, acc -> b.price + acc end)
        render(conn, "summary.html", books: books, full_price: full_price)
      end
  end

  def proceed_transaction(conn, params) do
    IO.inspect params
    products = prepare_products(conn)
    case products do
      nil ->
        put_flash(conn, :info, "Twój koszyk jest pusty")
        |> redirect(to: Routes.cart_path(conn, :index))
      products ->
        redirectUri = 
          Payu.create_new_order(products, params) 
          |> Map.get("redirectUri")
        empty_cart(conn)
        |> redirect(external: redirectUri)
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

  defp prepare_products(conn) do
    conn |> get_session(:cart) |> make_list()
  end

  defp make_list(ids) when ids in [[], %{}, nil, ""], do: nil

  defp make_list(ids) do
    Market.get_books_by_id_list(ids)
    |> Enum.map(fn book ->
      %{name: book.title, unitPrice: "#{round(book.price * 100)}", quantity: "1"} 
    end)
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

  def empty_cart(conn), do: conn |> put_session(:cart, nil)
end
