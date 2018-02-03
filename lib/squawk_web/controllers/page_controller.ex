defmodule SquawkWeb.PageController do
  use SquawkWeb, :controller

  def index(conn, _params) do
    sqwks = get_session(conn, :sqwks) || []

    sqwks = Enum.filter(sqwks, fn sqwk ->
      case DateTime.compare(sqwk.expiration, DateTime.utc_now()) do
        :gt -> true
        _ -> false
      end
    end)

    conn
    |> put_session(:sqwks, sqwks)
    |> render("index.html", sqwks: sqwks)
  end
end
