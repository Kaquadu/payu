defmodule BookShopWeb.Payu do
  alias BookShop.Payments

  @pos_id Application.get_env(:book_shop, :pos_id)
  @oauth_client_id Application.fetch_env!(:book_shop, :oauth_client_id)
  @oauth_secret Application.fetch_env!(:book_shop, :oauth_secret)
  @payu_api_url Application.fetch_env!(:book_shop, :payu_url)

  def hello do
    :world
  end

  def obtain_access_token() do
    data = %{
      grant_type: "client_credentials",
      client_id: @oauth_client_id,
      client_secret: @oauth_secret
    }

    headers = [{"Content-Type", "application/x-www-form-urlencoded"}]
    body = URI.encode_query(data)
    url = @payu_api_url <> "pl/standard/user/oauth/authorize"

    {:ok, %Tesla.Env{status: 200, body: resp}} = Tesla.post(url, body, headers: headers)

    resp
    |> Jason.decode!()
    |> Map.get("access_token")
  end

  def create_new_order(products, params) do
    total_sum = params |> Map.get("price")
    

    {total_sum, _} = Float.parse(total_sum)
    total_sum = round(total_sum * 100)
    data = %{
      notifyUrl: "https://your.eshop.com/notify",
      customerIp: "127.0.0.1",
      merchantPosId: @pos_id,
      description: "Book shop",
      currencyCode: "PLN",
      totalAmount: "#{total_sum}",
      products: products
    }

    token = obtain_access_token()

    headers = [{"Authorization", "Bearer #{token}"}, {"Content-Type", "application/json"}]
    body = Jason.encode!(data)
    url = @payu_api_url <> "api/v2_1/orders/"

    {:ok, %Tesla.Env{status: 302, body: resp}} = Tesla.post(url, body, headers: headers)
    # WRONG RETURNING JSON FORMAT - ",", which is working in JS, but not in elixir
    resp =
      resp
      |> String.replace("\"SUCCESS\",", "\"SUCCESS\"")
      |> Jason.decode!()

    transaction_key = Map.get(resp, "orderId")
    transaction_state = Payments.get_transaction_state("Proceeding")
    Payments.create( Map.merge(params, %{"transaction_key" => transaction_key, "transaction_state_id" => transaction_state.id}) )

    resp
  end
end


