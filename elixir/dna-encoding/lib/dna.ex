defmodule DNA do
  @dna_table_encode %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }
  @dna_table_decode Map.new(
                      @dna_table_encode,
                      fn {key, value} -> {value, key} end
                    )

  def encode_nucleotide(code_point) do
    @dna_table_encode[code_point]
  end

  def decode_nucleotide(encoded_code) do
    @dna_table_decode[encoded_code]
  end

  def encode([]), do: <<>>

  def encode([head | tail]) do
    <<encode_nucleotide(head)::4, encode(tail)::bitstring>>
  end

  def decode(<<>>), do: []

  def decode(<<x::4, y::bitstring>>) do
    [decode_nucleotide(x) | decode(y)]
  end
end
