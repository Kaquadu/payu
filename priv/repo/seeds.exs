# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BookShop.Repo.insert!(%BookShop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


conditions = [
  %{name: "New"},
  %{name: "Good"},
  %{name: "Secondhanded"},
  %{name: "Used"},
  %{name: "Bad"}
]

Enum.each(conditions, fn condition -> 
  BookShop.Market.create_book_condition(condition)
end)

shop_statuses = [
  %{name: "Available"},
  %{name: "Cart"},
  %{name: "Sold"}
]

Enum.each(shop_statuses, fn status -> 
  BookShop.Market.create_shop_status(status)
end)

transaction_states = [
  %{name: "Proceeding"},
  %{name: "Rejected"},
  %{name: "Positive"}
]

Enum.each(transaction_states, fn state ->
  BookShop.Payments.create_transaction_state(state)
end)
