defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number
    |> Integer.digits()
    |> (&pow_list(&1, length(&1))).()
    |> Enum.sum() == number
  end

  defp pow_list(xs, exp), do: Enum.map(xs, &Integer.pow(&1, exp))
end
