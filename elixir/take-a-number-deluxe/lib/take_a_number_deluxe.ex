defmodule TakeANumberDeluxe do
  use GenServer

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) when is_list(init_arg) do
    initial_state =
      TakeANumberDeluxe.State.new(
        Keyword.get(init_arg, :min_number),
        Keyword.get(init_arg, :max_number),
        Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
      )

    case initial_state do
      {:ok, initial_state} ->
        GenServer.start_link(
          __MODULE__,
          initial_state
        )

      {:error, error} ->
        {:error, error}
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    case GenServer.call(machine, :queue_new_number) do
      {:error, error} -> {:error, error}
      number -> {:ok, number}
    end
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    case GenServer.call(machine, {:serve_next_queued_number, priority_number}) do
      {:error, error} -> {:error, error}
      number -> {:ok, number}
    end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.call(machine, :reset_state)
  end

  # Server callbacks
  @impl GenServer
  def init(state), do: {:ok, state, state.auto_shutdown_timeout}

  @impl GenServer
  def handle_call(:report_state, _from, state), do: reply(state, state)

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} -> reply(new_number, new_state)
      {:error, error} -> reply({:error, error}, state)
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} -> reply(next_number, new_state)
      {:error, error} -> reply({:error, error}, state)
    end
  end

  @impl GenServer
  def handle_call(:reset_state, _from, state) do
    {_, new_state} =
      TakeANumberDeluxe.State.new(
        state.min_number,
        state.max_number,
        state.auto_shutdown_timeout
      )

    reply(:ok, new_state)
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}

  @impl GenServer
  def handle_info(_, state), do: noreply(state)

  # private functions
  defp reply(reply, new_state) do
    {:reply, reply, new_state, new_state.auto_shutdown_timeout}
  end

  defp noreply(new_state), do: {:noreply, new_state, new_state.auto_shutdown_timeout}
end
