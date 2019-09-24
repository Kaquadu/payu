defmodule BookShop.Repo do
  use Ecto.Repo,
    otp_app: :book_shop,
    adapter: Ecto.Adapters.Postgres
end
