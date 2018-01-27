defmodule SquawkWeb.Router do
  use SquawkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SquawkWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/squawk", SquawkController, :new
    post "/squawk", SquawkController, :create

	get "/:key", SquawkController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", SquawkWeb do
  #   pipe_through :api
  # end
end
