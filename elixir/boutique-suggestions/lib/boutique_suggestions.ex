defmodule BoutiqueSuggestions do
  @default_maximum_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = Keyword.get(options, :maximum_price, @default_maximum_price)

    for top <- tops,
        bottom <- bottoms,
        not clash?(top, bottom),
        outfit_price(top, bottom) <= maximum_price,
        do: {top, bottom}
  end

  defp outfit_price(top, bottom), do: top.price + bottom.price
  defp clash?(top, bottom), do: top.base_color == bottom.base_color
end
