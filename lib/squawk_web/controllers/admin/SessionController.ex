defmodule SquawkWeb.Admin.SessionController do
  use SquawkWeb, :controller
  alias Squawk.Bird

  def create(conn, %{"token" => token}) do
    case verify_token(token) do
      {:ok, handle} ->
        admin = Bird.get_admin_by_handle(handle)

        conn
        |> put_session(:admin_id, admin.id)
        |> put_flash(:info, "Hello, #{ admin.handle }!")
        |> redirect(to: page_path(conn, :index))
      {:error, error} ->
        conn |> redirect(to: page_path(conn, :index))
    end
  end

  @max_age 300
  defp verify_token(token) do
    Phoenix.Token.verify(SquawkWeb.Endpoint, "admin", token, max_age: @max_age)
  end
end
