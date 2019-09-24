defmodule BookShopWeb.Router do
  use BookShopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker, hisotry_size: 2
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BookShopWeb do
    pipe_through :browser

    resources "/books", BookController, only: [:index, :show]

    get "/", PageController, :index

    get "/cart", CartController, :index
    post "/add_to_cart", CartController, :add_to_cart
    delete "delete_from_cart", CartController, :remove_from_cart
  end

  scope "/admin", BookShopWeb, as: :admin do
    pipe_through :browser

    resources "/books", Admin.BookController, except: [:show, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BookShopWeb do
  #   pipe_through :api
  # end
end
