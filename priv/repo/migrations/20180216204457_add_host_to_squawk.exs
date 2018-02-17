defmodule Squawk.Repo.Migrations.AddHostToSquawk do
  use Ecto.Migration

  def change do
    alter table(:squawks) do
      add :host, :string
    end
  end
end
