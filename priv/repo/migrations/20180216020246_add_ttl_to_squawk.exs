defmodule Squawk.Repo.Migrations.AddTtlToSquawk do
  use Ecto.Migration

  def change do
    alter table(:squawks) do
      add :ttl, :integer
    end
  end
end
