defmodule Squawk.Nest.Key do
  use Ecto.Schema
  import Ecto.Changeset
  alias Squawk.Nest.Key


  schema "keys" do
    field :key, :string
    field :expiration, :utc_datetime
    field :squawk, :integer

    timestamps()
  end

  @doc false
  def changeset(%Key{} = key, attrs) do
    key
    |> cast(attrs, [:key, :expiration, :squawk])
    |> validate_required([:key, :expiration, :squawk])
  end
end
