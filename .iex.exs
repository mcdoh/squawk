alias Squawk.{Nest, Bird, Repo}
alias Squawk.Nest.Sqwk
alias Squawk.Nest.Key
alias Squawk.Bird.User

defmodule AdminTools do
  def create_admin(handle) do
    Bird.create_admin(handle)
  end

  def magiclink(handle) do
    case Bird.get_admin_by_handle!(handle) do
      nil -> "Error: #{ handle } is not an Admin. Try 'Admin.create_admin(\"#{ handle }\")"
      admin ->
        token = Phoenix.Token.sign(SquawkWeb.Endpoint, "admin", handle)
        "http://squawk.online/admin/magiclink?token=#{ token }"
    end
  end
end
