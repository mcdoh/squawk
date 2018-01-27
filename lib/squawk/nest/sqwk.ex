defmodule Squawk.Nest.Sqwk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Squawk.Nest.Sqwk


  schema "squawks" do
    field :expiration, :utc_datetime
    field :key, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Sqwk{} = sqwk, attrs) do
    sqwk
    |> cast(attrs, [:key, :url, :expiration])
    |> validate_required([:key, :url, :expiration])
  end
end
