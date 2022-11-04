defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    case histogram(strand) do
      {:error, _} -> 0
      histogram -> histogram[nucleotide] || 0
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @histogram_base %{?A => 0, ?C => 0, ?G => 0, ?T => 0} 
  @nucleotides Map.keys(@histogram_base)
  @nucleotides_count length(@nucleotides)

  @spec histogram(charlist()) :: map() | tuple()
  def histogram(strand) do
    h = strand
    |> Enum.group_by(&(&1))
    |> Enum.to_list()
    |> Enum.map(fn {codepoint, chars} -> {codepoint, length(chars)} end)
    |> Enum.into(@histogram_base)

    if (length(Map.keys(h)) != @nucleotides_count) do
      {:error, "strand contains invalid nucleotides"}
    else
      h
    end
  end
end
