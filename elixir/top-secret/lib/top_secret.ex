defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({op, _meta, children} = ast, acc) do
    if op in [:def, :defp] do
      function_tuple = get_first_children_but_not_guard(children)

      message_part =
        make_message_part(
          function_tuple |> get_op_from_tuple() |> Atom.to_string(),
          function_tuple |> get_children_from_tuple()
        )

      {ast, [message_part | acc]}
    else
      {ast, acc}
    end
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end

  # private functions

  defp get_op_from_tuple({op, _meta, _children}), do: op

  defp get_children_from_tuple({_op, _meta, children}), do: children

  defp get_first_children_but_not_guard([{:when, _metadata, args} | _tail]) do
    get_first_children_but_not_guard(args)
  end

  defp get_first_children_but_not_guard([head | _tail]), do: head

  defp make_message_part(_function_name, []), do: ""
  defp make_message_part(_function_name, nil), do: ""

  defp make_message_part(function_name, args) do
    String.slice(function_name, 0..(length(args) - 1))
  end
end
