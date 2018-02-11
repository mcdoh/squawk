defmodule SquawkWeb.Plugs.LoadUser do
  import Plug.Conn
  alias Squawk.Bird
  alias Squawk.Bird.User

  def init(_opts), do: nil

  def call(conn, _) do
    with user_id <- get_session(conn, :user_id),
      true <- is_integer(user_id),
      %User{} = user <- Bird.get_user(user_id)
    do
      conn |> assign(:test, %{user: "existing"})
    else
      _ -> user = Bird.create_user()
        conn
        |> put_session(:user_id, user.id)
        |> assign(:test, %{user: "new"})
    end
  end
end
