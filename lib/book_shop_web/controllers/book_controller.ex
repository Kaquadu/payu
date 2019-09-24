defmodule BookShopWeb.BookController do
  # uses
  use BookShopWeb, :controller
  # aliases
  alias BookShop.Market

  def index(conn, _params) do
    render(conn, "index.html", books: Market.get_all_not_sold_books())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", book: Market.get_book_by_id(id))
  end
end
