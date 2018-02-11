defmodule Squawk.Bird.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Squawk.Bird.User


  schema "users" do
    field :squawk_count, :integer

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:squawk_count])
    |> validate_required([:squawk_count])
  end
end
