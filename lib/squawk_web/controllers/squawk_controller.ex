defmodule SquawkWeb.SquawkController do
  use SquawkWeb, :controller
  alias Squawk.Nest
  alias Squawk.Bird

  def create(conn, %{"squawk" => squawk_request}) do
    user_id = get_session(conn, :user_id)

    user_ip = conn
    |> get_req_header("x-real-ip")
    |> Enum.at(0)

    new_sqwk = squawk_request
               |> Map.put("user_id", user_id)
               |> Map.put("user_ip", user_ip)
               |> Nest.create_squawk

	case new_sqwk do
	  {:ok, sqwk} ->
        Bird.increment_squawk_count(user_id)

        conn
		|> render("new.json", sqwk: sqwk)
	  {:error, error} ->
		render conn, "error.json", error: error
	end
  end

  def show(conn, %{"key" => key}) do
	case Nest.get_squawk(key) do
	  nil ->
		render(conn, "error.html", error: :key_not_set, key: key)
	  sqwk ->
        Nest.increment_squawk_views(sqwk.id)
		redirect(conn, external: sqwk.url)
	end
  end
end
