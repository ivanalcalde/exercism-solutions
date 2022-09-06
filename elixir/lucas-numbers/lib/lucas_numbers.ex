defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count)
      when not is_integer(count)
      when is_integer(count) and not (count >= 1) do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end

  def generate(1), do: [2]
  def generate(2), do: [2, 1]

  def generate(count) do
    base_case_list = generate(2)
    take_n = count - length(base_case_list)

    general_case_list =
      Stream.iterate({2, 1}, &generate_next_tuple/1)
      |> Enum.take(take_n)
      |> Enum.to_list()
      |> Enum.map(&tuple_to_lucas_number/1)

    base_case_list ++ general_case_list
  end

  defp generate_next_tuple({n1, n2}), do: {n2, n1 + n2}
  defp tuple_to_lucas_number({n1, n2}), do: n1 + n2
end
