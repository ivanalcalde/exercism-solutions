defmodule ResistorColor do
  @band_colors [
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  ]

  @doc """
  Return the value of a color band
  """
  @spec code(atom | String.t()) :: integer()
  def code(color) when is_bitstring(color), do: code(String.to_atom(color))
  def code(color) when is_atom(color), do: @band_colors[color]

  @doc """
  Return the list of the colors
  """
  @spec colors() :: [String.t()]
  def colors() do
    @band_colors
    |> Keyword.keys()
    |> Enum.map(&Atom.to_string/1)
  end
end
