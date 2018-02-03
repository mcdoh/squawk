defmodule SquawkWeb.SquawkController do
  use SquawkWeb, :controller
  alias Squawk.Nest

  def create(conn, %{"squawk" => squawk_request}) do
    IO.puts "CREATE CREATE CREATE"
	case Nest.create_squawk(squawk_request) do
	  {:ok, sqwk} ->
        sqwks = get_session(conn, :sqwks) || []
        sqwks = [sqwk | sqwks]

        conn
        |> put_session(:sqwks, sqwks)
		|> render("new.html", sqwk: sqwk)
	  {:error, error} ->
		render conn, "error.html", error: error
	end
  end

  def show(conn, %{"key" => key}) do
	case Nest.get_squawk(key) do
	  nil ->
		render(conn, "error.html", error: :key_not_set, key: key)
	  sqwk ->
		redirect(conn, external: sqwk.url)
	end
  end
end
