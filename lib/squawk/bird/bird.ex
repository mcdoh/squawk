defmodule Squawk.Bird do
  import Ecto.Query

  alias Squawk.Repo
  alias Squawk.Bird.User
  alias Squawk.Bird.Admin

  def create_user do
    %User{squawk_count: 0}
    |> Repo.insert!
  end

  def create_admin(handle) do
    %Admin{handle: handle}
    |> Repo.insert!
  end

  def get_user(id), do: Repo.get(User, id)
  def get_user!(id), do: Repo.get!(User, id)

  def get_admin(id), do: Repo.get(Admin, id)
  def get_admin!(id), do: Repo.get!(Admin, id)

  def get_admin_by_handle(handle), do: Repo.get_by(Admin, handle: handle)
  def get_admin_by_handle!(handle), do: Repo.get_by!(Admin, handle: handle)

  def increment_squawk_count(id) do
    user = User
    |> where([u], u.id == ^id)
    |> lock("FOR UPDATE")
    |> Repo.one

    user
    |> User.changeset(%{
      squawk_count: user.squawk_count + 1
    })
    |> Repo.update!
  end

  def set_admin_ip(id, ip) do
    get_admin(id)
    |> Admin.changeset(%{ip: ip})
    |> Repo.update!
  end
end
