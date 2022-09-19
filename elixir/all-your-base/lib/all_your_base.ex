defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert(_, input_base, _) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(digits, input_base, output_base) do
    if(Enum.all?(digits, fn digit -> digit in 0..(input_base - 1) end)) do
      result =
        digits
        |> digits_to_decimal_number(input_base)
        |> decimal_number_to_base(output_base)

      {:ok, result}
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp digits_to_decimal_number(digits, base) do
    exponent = length(digits) - 1
    acc = {0, exponent}

    {number, _} =
      digits
      |> Enum.reduce(acc, fn digit, {total, exponent} ->
        {total + digit * Integer.pow(base, exponent), exponent - 1}
      end)

    number
  end

  defp decimal_number_to_base(number, base, digits \\ []) do
    {quotient, remainder} = get_quotient_and_remainder(number, base)

    digits = [remainder | digits]

    if quotient == 0 do
      digits
    else
      decimal_number_to_base(quotient, base, digits)
    end
  end

  defp get_quotient_and_remainder(dividend, divisor) do
    quotient = div(dividend, divisor)
    remainder = rem(dividend, divisor)

    {quotient, remainder}
  end
end
