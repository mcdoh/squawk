defmodule SquawkWeb.Router do
  use SquawkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SquawkWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", SquawkWeb.Admin, as: :admin do
    pipe_through :browser

    get "/magiclink", SessionController, :create
  end

  scope "/admin", SquawkWeb.Admin, as: :admin do
    pipe_through [:browser, SquawkWeb.Plugs.LoadAdmin]

    get "/", DashboardController, :index
  end

  scope "/", SquawkWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    post "/squawk", SquawkController, :create

	get "/:key", SquawkController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", SquawkWeb do
  #   pipe_through :api
  # end
end
