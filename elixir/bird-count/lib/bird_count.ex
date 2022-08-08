defmodule BirdCount do
  def today([]), do: nil

  def today([today_count | _tail]), do: today_count

  def increment_day_count([]), do: [1]

  def increment_day_count([today_count | tail]) do
    [today_count + 1 | tail]
  end

  def has_day_without_birds?(list), do: 0 in list

  def total(list), do: Enum.sum(list)

  def busy_days(list) do
    Enum.count(list, fn n -> n >= 5 end)
  end
end
