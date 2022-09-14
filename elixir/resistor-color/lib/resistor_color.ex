defmodule ResistorColor do
  @band_colors [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
  ]

  @doc """
  Return the value of a color band
  """
  @spec code(atom | String.t()) :: integer()
  def code(color) when is_bitstring(color) do
    Enum.find_index(@band_colors, &(&1 == color))
  end

  def code(color) when is_atom(color), do: code(Atom.to_string(color))

  # @doc """
  # Return the list of the colors
  # """
  # @spec colors() :: [String.t()]
  # def colors(), do: @band_colors
end
