defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """

  @vowels ~w(a e i o u)
  @consonants ~w(b c d f g h j k l m n p q r s t v w x y z)

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    "#{process_word(word)}ay"
  end

  defp process_word(word)
    when binary_part(word, 0, 1) in @vowels,
    do: word

  defp process_word("qu" <> _ = word), do: move_letters_to_end(word, 2)

  defp process_word(word)
    when binary_part(word, 0, 1) in @consonants
    and binary_part(word, 1, 2) == "qu",
    do: move_letters_to_end(word, 3)

  defp process_word(word)
    when binary_part(word, 0, 1) in ~w(x y)
    and binary_part(word, 1, 1) in @consonants,
    do: word

  defp process_word("y" <> _ = word), do: move_letters_to_end(word, 1)

  defp process_word(word) do
    consonants_to_match = @consonants -- ~w(y)

    r = Regex.compile!("(?<first_consonants>[#{Enum.join(consonants_to_match)}]+)")

    %{"first_consonants" => first_consonants} = Regex.named_captures(r, word)

    move_letters_to_end(word, String.length(first_consonants))
  end

  defp move_letters_to_end(word, count) do
    {first_part, second_part} = String.graphemes(word) |> Enum.split(count)
    
    (second_part ++ first_part) |> Enum.join()
  end
end
