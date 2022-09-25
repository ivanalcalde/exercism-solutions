defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram_of?(base, &1))
  end

  defp anagram_of?(target, word) do
    not same_word?(target, word) &&
      normalize(target) == normalize(word)
  end

  defp same_word?(w1, w2) do
    String.downcase(w1) == String.downcase(w2)
  end

  defp normalize(word) do
    word |> String.downcase() |> sorted_word()
  end

  defp sorted_word(word) do
    word
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end
end
