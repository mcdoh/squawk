defmodule Squawk.Repo.Migrations.AddUserAndIpToSquawks do
  use Ecto.Migration

  def change do
    alter table(:squawks) do
      add :user_id, references(:users)
      add :user_ip, :string
    end
  end
end
