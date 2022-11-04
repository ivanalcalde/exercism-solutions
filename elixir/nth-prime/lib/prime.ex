defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when is_integer(count) and count > 0 do
    lazy_primes()
    |> Stream.drop(count - 1)
    |> Stream.take(1)
    |> Enum.at(0)
  end

  defp lazy_primes() do
    Stream.iterate(2, &(&1+1))
    |> Stream.map(fn number -> { number, prime?(number) } end)
    |> Stream.filter(fn {_, is_prime} -> is_prime end)
    |> Stream.map(fn {number, _} -> number end)
  end

  defp prime?(2), do: true
  defp prime?(3), do: true
  defp prime?(number) do
    divisors = 2..(div(number, 2))

    divisors
    |> Stream.map(&(rem(number, &1) == 0))
    |> Stream.filter(&(&1 == true))
    |> Enum.empty?()
  end
end



