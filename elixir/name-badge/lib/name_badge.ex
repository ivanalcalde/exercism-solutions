defmodule NameBadge do
  def print(id, name, department) do
    [
      if(id, do: format_id(id), else: nil),
      name,
      if(department, do: format_department(department), else: "OWNER")
    ]
    |> Enum.filter(&(not is_nil(&1)))
    |> Enum.join(" - ")
  end

  defp format_id(id) when is_integer(id) do
    "[#{Integer.to_string(id)}]"
  end

  defp format_department(department) when is_bitstring(department) do
    department |> String.upcase()
  end
end
