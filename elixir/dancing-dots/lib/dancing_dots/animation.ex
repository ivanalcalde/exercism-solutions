defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, String.t()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _) when rem(frame_number, 4) == 0 do
    %{dot | opacity: dot.opacity / 2}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @opts_validations [
    {:velocity, validate_type: "number", validate_required: true}
  ]

  @impl DancingDots.Animation
  def init(opts) do
    case validate_opts(opts) do
      {:ok} -> {:ok, opts}
      {:error, [first_error | _t]} -> {:error, first_error}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, velocity: velocity) do
    radius_inc = (frame_number - 1) * velocity

    %{dot | radius: dot.radius + radius_inc}
  end

  defp valid_type?("number", value), do: is_number(value)

  defp validate_opt(
         {field, [validate_type: type, validate_required: required?]},
         {opts, errors} = acc
       ) do
    opt_value = Keyword.get(opts, field)

    error_message = make_error_message(field, type, opt_value)

    case opt_value do
      nil ->
        if(required?) do
          {opts, [error_message | errors]}
        else
          acc
        end

      opt_value ->
        if(valid_type?(type, opt_value)) do
          acc
        else
          {opts, [error_message | errors]}
        end
    end
  end

  defp validate_opts(opts) do
    {_opts, errors} =
      @opts_validations
      |> Enum.reduce({opts, []}, &validate_opt/2)

    case errors do
      [] -> {:ok}
      errors -> {:error, errors}
    end
  end

  defp make_error_message(field, type, value) do
    "The :#{field} option is required, and its value must be a #{type}. Got: #{inspect(value)}"
  end
end
