defmodule BoutiqueInventory do
  def sort_by_price([]), do: []

  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price([]), do: []

  def with_missing_price(inventory) do
    Enum.reject(inventory, & &1.price)
  end

  def update_names([], _old_word, _new_word), do: []

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &update_name(&1, old_word, new_word))
  end

  def increase_quantity(item, count) do
    Map.put(
      item,
      :quantity_by_size,
      Map.new(item.quantity_by_size, fn {size, qty} -> {size, qty + count} end)
    )
  end

  # def total_quantity(item) do
  #   item.quantity_by_size
  #   |> Map.values()
  #   |> Enum.sum()
  # end
  def total_quantity(item) do
    Enum.reduce(
      item.quantity_by_size,
      0,
      fn {_size, qty}, acc -> acc + qty end
    )
  end

  defp update_name(item, old_word, new_word) do
    Map.put(item, :name, String.replace(item.name, old_word, new_word))
  end
end
