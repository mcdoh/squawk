defmodule Squawk.Repo.Migrations.UrlStringToText do
  use Ecto.Migration

  def change do
    alter table(:squawks) do
      modify :url, :text
    end
  end
end
