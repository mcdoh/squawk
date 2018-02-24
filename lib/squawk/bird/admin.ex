defmodule Squawk.Bird.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Squawk.Bird.Admin


  schema "admins" do
    field :handle, :string
    field :ip, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:handle, :ip])
    |> validate_required([:handle, :ip])
  end
end
