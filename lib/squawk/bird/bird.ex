defmodule Squawk.Bird do
  alias Squawk.Repo
  alias Squawk.Bird.User

  def create_user do
    %User{squawk_count: 0}
    |> Repo.insert!
  end

  def get_user(id), do: Repo.get(User, id)
  def get_user!(id), do: Repo.get!(User, id)
end
