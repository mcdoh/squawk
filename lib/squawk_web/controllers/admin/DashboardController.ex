defmodule SquawkWeb.Admin.DashboardController do
  use SquawkWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end
end
