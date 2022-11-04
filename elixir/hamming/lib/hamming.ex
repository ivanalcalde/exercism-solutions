defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "strands must be of equal length"}
  end

  def hamming_distance(strand1, strand2) do
    if strand1 == strand2 do
      {:ok, 0}
    else
      {:ok, count_diff(to_string(strand1), to_string(strand2), 0)}
    end
  end

  defp count_diff("", "", acc), do: acc

  defp count_diff(<<c1, rest1::binary>>, <<c2, rest2::binary>>, acc) do
    count_diff(rest1, rest2, acc + if(c1 != c2, do: 1, else: 0)) 
  end
end
