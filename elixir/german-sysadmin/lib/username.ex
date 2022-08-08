defmodule Username do
  def sanitize(username) do
    username
    |> Enum.map(&map_char/1)
    |> List.to_charlist()
  end

  defp map_char(char) do
    case char do
      char when char in 'abcdefghijklmnopqrstuvwxyz_' -> char
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      _ -> ''
    end
  end
end
