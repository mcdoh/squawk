defmodule Squawk.Nest do
  import Ecto.Query

  alias Squawk.Repo
  alias Squawk.Nest.Sqwk

  @one_second 60

  def list_all do
    Repo.all(Sqwk)
  end

  def get_squawk(key) do
    Sqwk
    |> where([s], s.key == ^key)
    |> where([s], s.expiration > ^DateTime.utc_now)
    |> Repo.one
  end

  def create_squawk(attrs \\ %{}) do
    sqwks = Sqwk
           |> where([s], s.expiration < ^DateTime.utc_now)
           |> or_where([s], is_nil(s.expiration))
           |> Repo.all

    if length(sqwks) > 0 do
      sqwks
      |> Enum.random
      |> Sqwk.changeset(%{url: attrs["url"], expiration: create_expiration(attrs["ttl"])})
      |> Repo.update
    else
      {:error, :out_of_words}
    end
  end

  defp create_expiration(ttl) do
    DateTime.utc_now
    |> DateTime.to_unix
    |> Kernel.+(String.to_integer(ttl) * @one_second)
    |> DateTime.from_unix!(:second)
  end
end
