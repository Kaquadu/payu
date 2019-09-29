defmodule BookShop.Payments do
  import Ecto.Query
  # aliases
  alias BookShop.Repo
  alias BookShop.Payments.{ Transaction, TransactionState }

  def create(attrs) do
    %Transaction{} |> Transaction.changeset(attrs) |> Repo.insert()
  end

  def create_transaction_state(attrs) do
    %TransactionState{} |> TransactionState.changeset(attrs) |> Repo.insert()
  end

  def get_transactions(), do: Repo.all(Transaction)

  def update(transaction, attrs) do
    Transaction.changeset(transaction, attrs) |> Repo.update()
  end

  def get_transaction_state(name) do
    Repo.get_by(TransactionState, name: name)
  end
end
