defmodule BookShopWeb.Admin.BookController do
  # uses
  use BookShopWeb, :controller
  # aliases
  alias BookShop.Market
  alias BookShop.Market.{ Book }

  def index(conn, _params) do
    render(conn, "index.html", books: Market.get_all_books())
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: Book.changeset(%Book{ condition: Market.get_default_condition(), shop_status: Market.get_default_shop_status() }))
  end

  def create(conn, %{"book" => book}) do
    book = Map.merge(book, %{"shop_status_id" => "1"})
    case Market.create_book(book) do
      {:ok, book} -> 
        redirect(conn, to: Routes.book_path(conn, :show, book))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Ooops, something went wrong.")
        |> render("new.html", changeset: changeset)
    end
  end
end
