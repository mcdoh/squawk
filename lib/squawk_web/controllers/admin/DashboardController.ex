defmodule SquawkWeb.Admin.DashboardController do
  use SquawkWeb, :controller
  alias Squawk.Nest

  def index(conn, _) do
    key_usage = Nest.get_key_usage
    render(conn, "index.html", key_usage: key_usage)
  end
end
