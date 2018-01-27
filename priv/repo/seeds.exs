alias Squawk.Repo
alias Squawk.Nest.Sqwk

"priv/seed_data/words.txt"
|> File.stream!
|> Stream.map(fn word_line ->
  key = String.trim_trailing word_line

  if (key != "") do
    %Sqwk{key: key}
    |> Repo.insert!
  end
end)
|> Stream.run

