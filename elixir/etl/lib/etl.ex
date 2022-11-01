defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.to_list()
    |> Enum.map(fn {score, letters} -> 
      for letter <- letters, do: {letter, score}
    end)
    |> List.flatten()
    |> Enum.map(fn {letter,score} -> {String.downcase(letter),score} end)
    |> Enum.into(%{})
  end
end
