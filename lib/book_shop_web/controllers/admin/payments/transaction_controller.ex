defmodule BookShopWeb.Admin.TransactionController do
  use BookShopWeb, :controller

  alias BookShop.Payments

  def index(conn, _params) do
    transactions = Payments.get_transactions()
    render(conn, "index.html", transactions: transactions)
  end
end
