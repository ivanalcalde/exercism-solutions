defmodule Allergies do
  @allergies %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats"
  }

  # @steps [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, ...]
  @steps Stream.scan(
           1..20,
           fn n1, n2 -> if(n1 == 1, do: 1, else: n2 * 2) end
         )
         |> Enum.to_list()
         |> Enum.reverse()

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) when flags > 0 do
    close_step_number = get_close_step_number(flags)

    [@allergies[close_step_number] | list(flags - close_step_number)]
    |> Enum.reject(&is_nil/1)
  end

  def list(_), do: []

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
  end

  defp get_close_step_number(n) do
    Enum.max_by(
      @steps,
      fn step -> if(step > n, do: 0, else: step) end
    )
  end
end
