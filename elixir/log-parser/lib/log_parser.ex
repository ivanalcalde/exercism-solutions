defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG|INFO|WARNING|ERROR\]/
  end

  def split_line(line) do
    String.split(line, ~r/<(=|~|\*|-)*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/i, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)\s*/, line) do
      nil ->
        line

      [_user_string, user_name | _tail] ->
        String.replace_prefix(line, "", "[USER] #{user_name} ")
    end
  end
end
