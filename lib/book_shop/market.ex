defmodule BookShop.Market do
  # aliases
  alias BookShop.Repo
  alias BookShop.Market.{ Book, BookCondition, ShopStatus }
  # imports
  import Ecto.Query

  def create_book_condition(attrs) do
    %BookCondition{} |> BookCondition.changeset(attrs) |> Repo.insert()
  end

  def create_shop_status(attrs) do
    %ShopStatus{} |> ShopStatus.changeset(attrs) |> Repo.insert()
  end

  def create_book(attrs) do
    %Book{} |> Book.changeset(attrs) |> Repo.insert()
  end

  def get_all_books() do
    Repo.all(Book) |> Repo.preload(:condition)
  end

  def get_all_not_sold_books() do
    Repo.all(from b in Book,
    left_join: status in assoc(b, :shop_status),
    where: status.name == "Available")
    |> Repo.preload(:condition)
  end

  def get_book_by_id(id) do
    Repo.get_by(Book, id: id)
  end

  def get_books_by_id_list(id_list) do
    list = Map.keys(id_list)
    Repo.all(from b in Book,
    where: b.id in ^list)
    |> Repo.preload(:condition)
  end

  def get_all_book_conditions() do
    Repo.all(BookCondition)
  end

  def get_default_condition() do
    c = BookCondition |> first |> Repo.one()
    c.name
  end

  def get_default_shop_status() do
    s =
      Repo.get_by(ShopStatus, name: "Available")
    s.name
  end
end
