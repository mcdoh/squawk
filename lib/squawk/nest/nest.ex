defmodule Squawk.Nest do
  import Ecto.Query

  alias Squawk.Repo
  alias Squawk.Nest.Key
  alias Squawk.Nest.Sqwk

  @one_second 60

  def list_all do
    Repo.all(Sqwk)
  end

  def get_squawk(key) do
    squawk_key = Key
    |> where([s], s.key == ^key)
    |> where([s], s.expiration > ^DateTime.utc_now)
    |> Repo.one

    if squawk_key do
      Repo.get(Sqwk, squawk_key.squawk)
    else
      nil
    end
  end

  def get_key_usage do
    %{
      used: Key
            |> where([k], k.expiration > ^DateTime.utc_now)
            |> Repo.all
            |> Enum.count,
      total: Key
             |> Repo.all
             |> Enum.count
    }
  end

  def get_user_squawks(user_id) do
    Sqwk
    |> where([s], s.user_id == ^user_id)
    |> where([s], s.expiration > ^DateTime.utc_now)
    |> order_by(desc: :inserted_at)
    |> Repo.all
  end

  def create_squawk(attrs \\ %{}) do
    key = Key
          |> where([k], k.expiration < ^DateTime.utc_now)
          |> Repo.all
          |> Enum.random

    if key do
      key = Key
            |> where([k], k.id == ^key.id)
            |> lock("FOR UPDATE")
            |> Repo.one

      expiration = create_expiration(attrs["ttl"])

      sqwk = %Sqwk{
        key: key.key,
        expiration: expiration,
        url: attrs["url"],
        user_id: attrs["user_id"],
        user_ip: attrs["user_ip"],
        ttl: String.to_integer(attrs["ttl"]),
        host: URI.parse(attrs["url"]).host,
        views: 0
      }
      |> Repo.insert!

      key
      |> Key.changeset(%{
        expiration: expiration,
        squawk: sqwk.id
      })
      |> Repo.update

      {:ok, sqwk}
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

  def increment_squawk_views(id) do
    sqwk = Sqwk
    |> where([s], s.id == ^id)
    |> lock("FOR UPDATE")
    |> Repo.one

    sqwk
    |> Sqwk.changeset(%{
      views: sqwk.views + 1
    })
    |> Repo.update!
  end
end
