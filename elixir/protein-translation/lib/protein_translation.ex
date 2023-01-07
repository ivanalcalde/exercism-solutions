defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    proteins = 
      rna
      |> String.graphemes() 
      |> Enum.chunk_every(3) 
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&of_codon/1)
      |> Enum.reduce_while([], fn {res, protein}, acc -> 
        if protein == "STOP" do
          {:halt, acc}
        else
          {:cont, acc ++ [{res, protein}]}
        end
      end)

    if (Enum.any?(proteins, fn {res, _} -> res == :error end)) do
      {:error, "invalid RNA"}
    else
      {:ok, proteins |> Enum.map(fn {_, protein} -> protein end)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    if Map.has_key?(@codons, codon) do
      {:ok, Map.get(@codons, codon)}
    else
      {:error, "invalid codon"}
    end
  end
end
