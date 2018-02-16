defmodule Squawk.Nest.Sqwk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Squawk.Nest.Sqwk


  schema "squawks" do
    field :expiration, :utc_datetime
    field :key, :string
    field :url, :string
    field :user_id, :integer
    field :user_ip, :string
    field :ttl, :integer

    timestamps()
  end

  @doc false
  def changeset(%Sqwk{} = sqwk, attrs) do
    sqwk
    |> cast(attrs, [:key, :url, :expiration, :user_id, :user_ip, :ttl])
    |> validate_required([:key, :url, :expiration])
  end
end
