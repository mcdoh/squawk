defmodule SquawkWeb.PageController do
  use SquawkWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
