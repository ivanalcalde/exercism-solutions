defmodule FileSniffer do
  @make_binary_regex fn binary -> Regex.compile!("^#{binary}") end

  @media_types [
    {"exe", "application/octet-stream", @make_binary_regex.(<<0x7F, 0x45, 0x4C, 0x46>>)},
    {"bmp", "image/bmp", @make_binary_regex.(<<0x42, 0x4D>>)},
    {"png", "image/png", @make_binary_regex.(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>)},
    {"jpg", "image/jpg", @make_binary_regex.(<<0xFF, 0xD8, 0xFF>>)},
    {"gif", "image/gif", @make_binary_regex.(<<0x47, 0x49, 0x46>>)}
  ]

  def type_from_extension(extension) do
    find_type_from_extension(extension)
    |> media_type_from_tuple()
  end

  def type_from_binary(file_binary) do
    find_type_from_binary(file_binary)
    |> media_type_from_tuple()
  end

  def verify(file_binary, extension) do
    case find_type_from_binary(file_binary) do
      {^extension, content_type, _file_binary_regex} ->
        {:ok, content_type}

      _ ->
        {:error, "Warning, file format and file extension do not match."}
    end
  end

  defp find_type_from_extension(extension_to_match) do
    Enum.find(
      @media_types,
      fn {extension, _media_type, _file_binary_regex} ->
        extension == extension_to_match
      end
    )
  end

  defp find_type_from_binary(file_binary) do
    Enum.find(
      @media_types,
      fn {_ext, _media_type, file_binary_regex} ->
        file_binary =~ file_binary_regex
      end
    )
  end

  defp media_type_from_tuple(nil), do: nil
  defp media_type_from_tuple(tuple), do: elem(tuple, 1)
end
