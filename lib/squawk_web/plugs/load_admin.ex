defmodule SquawkWeb.Plugs.LoadAdmin do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  alias Squawk.Bird

  def init(_opts), do: nil

  def call(conn, _opts) do
    case get_session(conn, :admin_id) do
      nil ->
        IO.inspect conn
        IO.puts "not an admin"
        conn
        |> redirect(to: "/")
        |> halt
      admin_id ->
        admin = Bird.get_admin(admin_id)
        conn
        |> assign(:admin, admin)
    end
  end
end
