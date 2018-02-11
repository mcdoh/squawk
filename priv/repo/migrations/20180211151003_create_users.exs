defmodule Squawk.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :squawk_count, :integer

      timestamps()
    end

  end
end
