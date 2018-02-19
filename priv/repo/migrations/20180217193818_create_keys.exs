defmodule Squawk.Repo.Migrations.CreateKeys do
  use Ecto.Migration

  def change do
    create table(:keys) do
      add :key, :string
      add :expiration, :utc_datetime
      add :squawk, references(:squawks)

      timestamps()
    end

    create index(:keys, [:key])
    create index(:keys, [:expiration])
  end
end
