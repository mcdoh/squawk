defmodule Squawk.Repo.Migrations.CreateSquawks do
  use Ecto.Migration

  def change do
    create table(:squawks) do
      add :key, :string
      add :url, :string
      add :expiration, :utc_datetime

      timestamps()
    end

  end
end
