import  Ecto.Query

alias Squawk.Repo

alias Squawk.Nest
alias Squawk.Nest.Sqwk
alias Squawk.Nest.Key

alias Squawk.Bird
alias Squawk.Bird.User

defmodule AdminTools do
  def add_key(key) do
    %Key{key: key, expiration: DateTime.utc_now}
    |> Repo.insert!
  end

  def create_admin(handle) do
    Bird.create_admin(handle)
  end

  def get_live_squawks do
    Sqwk
    |> where([s], s.expiration > ^DateTime.utc_now)
    |> Repo.all
    |> Enum.map(fn(sqwk) -> %{key: sqwk.key, host: sqwk.host, ttl: time_remaining(sqwk.expiration)} end)
  end

  def magiclink(handle) do
    case Bird.get_admin_by_handle!(handle) do
      nil -> "Error: #{ handle } is not an Admin. Try 'Admin.create_admin(\"#{ handle }\")"
      _admin ->
        token = Phoenix.Token.sign(SquawkWeb.Endpoint, "admin", handle)
        "http://squawk.online/admin/magiclink?token=#{ token }"
    end
  end

  defp time_remaining(expiration) do
    total_seconds = (DateTime.to_unix(expiration) - DateTime.to_unix(DateTime.utc_now))

    hours = div(total_seconds, 3600)
    minutes = div(rem(total_seconds, 3600), 60)
    seconds = rem(total_seconds, 60)

    hours_display = if hours > 0 do
      "#{ hours }:"
    else
      ""
    end

    minutes_display = if hours > 0 and minutes < 10 do
      "0#{ minutes }:"
    else
      "#{ minutes }:"
    end

    seconds_display = if seconds < 10 do
      "0#{ seconds }"
    else
      "#{ seconds }"
    end

    "#{ hours_display }#{ minutes_display }#{ seconds_display }"
  end
end
