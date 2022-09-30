defmodule CollatzConjecture do
  import Integer

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    calc_step(input, 0)
  end

  defp calc_step(1, steps), do: steps

  defp calc_step(n, steps) when is_integer(n) and n > 1 do
    if Integer.is_odd(n) do
      calc_step(n * 3 + 1, steps + 1)
    else
      calc_step(div(n, 2), steps + 1)
    end
  end
end
