defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception([]), do: %StackUnderflowError{}

    def exception(value) do
      %StackUnderflowError{message: "stack underflow occurred, context: #{value}"}
    end
  end

  def divide([0, _dividend]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend]), do: dividend / divisor
  def divide(_), do: raise(StackUnderflowError, "when dividing")
end
