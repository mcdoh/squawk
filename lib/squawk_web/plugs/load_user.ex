defmodule SquawkWeb.Plugs.LoadUser do
  import Plug.Conn
  alias Squawk.Nest
  alias Squawk.Bird
  alias Squawk.Bird.User

  def init(_opts), do: nil

  def call(conn, _) do
    with user_id <- get_session(conn, :user_id),
      true <- is_integer(user_id),
      %User{} = user <- Bird.get_user(user_id)
    do
      sqwks = Nest.get_user_squawks(user_id)
      conn |> assign(:sqwks, sqwks)
    else
      _ -> user = Bird.create_user()
        conn
        |> put_session(:user_id, user.id)
        |> assign(:sqwks, [])
    end
  end
end
