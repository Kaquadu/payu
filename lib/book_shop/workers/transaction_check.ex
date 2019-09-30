defmodule BookShop.Workers.TransactionCheck do
  use GenServer

  alias BookShop.Payments
  alias BookShopWeb.Payu

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    schedule_work(1)
    {:ok, state}
  end

  def handle_info(:work, state) do
    Payments.get_not_finished_transactions()
    |> Enum.each(fn t ->
      order_status = Payu.get_order_info(t.transaction_key)
      |> Map.get("orders") |> List.first() |> Map.get("status")
      case order_status do
        "COMPLETED" -> 
          state = Payments.get_transaction_state("Positive")
          attrs = %{transaction_state_id: state.id}
          Payments.update(t, attrs)
        _ ->
          nil
      end
    end)
    schedule_work(2 * 60 * 1000)
    {:noreply, state}
  end

  defp schedule_work(time) do
    Process.send_after(self(), :work, time)
  end

end
