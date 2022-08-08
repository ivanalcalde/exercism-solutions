# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> [] end)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1)
  end

  def register(pid, register_to) do
    plot = %Plot{plot_id: make_plot_id(), registered_to: register_to}

    Agent.get_and_update(pid, fn xs ->
      {plot, [plot | xs]}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(
      pid,
      &Enum.reject(&1, match_plot_id(plot_id))
    )
  end

  def get_registration(pid, plot_id) do
    plot =
      Agent.get(
        pid,
        &Enum.find(&1, match_plot_id(plot_id))
      )

    cond do
      is_nil(plot) -> {:not_found, "plot is unregistered"}
      true -> plot
    end
  end

  defp make_plot_id() do
    {:ok, dt} = DateTime.now("Etc/UTC")
    DateTime.to_string(dt)
  end

  defp match_plot_id(plot_id), do: fn plot -> plot.plot_id == plot_id end
end
