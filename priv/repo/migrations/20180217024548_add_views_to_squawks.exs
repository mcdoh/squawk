defmodule Squawk.Repo.Migrations.AddViewsToSquawks do
  use Ecto.Migration

  def change do
    alter table(:squawks) do
      add :views, :integer
    end
  end
end
