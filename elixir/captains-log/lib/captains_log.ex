defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-#{Enum.random(1000..9999)}"
  end

  def random_stardate() do
    range_start = 41_000
    range_end = 42_000
    range_width = range_end - range_start

    :rand.uniform() * range_width + range_start
  end

  def format_stardate(stardate) when not is_float(stardate), do: raise(ArgumentError)

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [Float.ceil(stardate, 2)])
    |> to_string()
  end
end
