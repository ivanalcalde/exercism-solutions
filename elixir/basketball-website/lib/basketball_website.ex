defmodule BasketballWebsite do
  @path_separator "."

  def extract_from_path(data, ""), do: data

  def extract_from_path(data, path) do
    [path_part | path_parts] = to_path_parts(path)
    extract_from_path(data[path_part], to_path(path_parts))
  end

  def get_in_path(data, path) do
    get_in(data, to_path_parts(path))
  end

  defp to_path_parts(path), do: path |> String.split(@path_separator)
  defp to_path(path_parts), do: Enum.join(path_parts, @path_separator)
end
