defmodule TwoFer do
  @moduledoc """
  `Two-fer` or `2-fer` is short for two for one.
  One for you and one for me.
  """

  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.

  ## Examples

    iex> TwoFer.two_fer()
    "One for you, one for me."

    iex> TwoFer.two_fer("Joe")
    "One for Joe, one for me."

    iex> TwoFer.two_fer(10)
    ** (FunctionClauseError) no function clause matching in TwoFer.two_fer/1

    iex> TwoFer.two_fer(:joe)
    ** (FunctionClauseError) no function clause matching in TwoFer.two_fer/1

    iex> TwoFer.two_fer('Joe Rogan')
    ** (FunctionClauseError) no function clause matching in TwoFer.two_fer/1
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") when is_bitstring(name) do
    "One for #{name}, one for me."
  end
end
