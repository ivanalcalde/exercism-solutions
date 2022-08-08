defmodule TakeANumber do
  @initial_state 0

  def start, do: spawn(&loop/0)

  defp loop(state \\ @initial_state) do
    new_state =
      receive do
        {:report_state, from} ->
          send(from, state)

        {:take_a_number, from} ->
          send(from, state + 1)

        :stop ->
          :stop

        _ ->
          state
      end

    case new_state do
      :stop -> nil
      _ -> loop(new_state)
    end
  end
end
