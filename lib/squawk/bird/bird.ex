defmodule Squawk.Bird do
  import Ecto.Query

  alias Squawk.Repo
  alias Squawk.Bird.User

  def create_user do
    %User{squawk_count: 0}
    |> Repo.insert!
  end

  def get_user(id), do: Repo.get(User, id)
  def get_user!(id), do: Repo.get!(User, id)

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
end
