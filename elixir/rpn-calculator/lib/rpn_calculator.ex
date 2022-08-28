defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      calculate!(stack, operation)
      |> (&{:ok, &1}).()
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      calculate!(stack, operation)
      |> (&{:ok, &1}).()
    rescue
      error in ArgumentError -> {:error, error.message}
    end
  end
end
