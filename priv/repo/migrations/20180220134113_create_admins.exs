defmodule Squawk.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"
    create table(:admins) do
      add :handle, :citext
      add :ip, :string

      timestamps()
    end

    create unique_index(:admins, [:handle])
  end
end
