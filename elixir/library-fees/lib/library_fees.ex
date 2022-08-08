defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime)
    |> Time.compare(~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days_to_return(checkout_datetime))
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(
      NaiveDateTime.to_date(actual_return_datetime),
      planned_return_date
    )
    |> (&if(&1 > 0, do: &1, else: 0)).()
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    planned_return_date = datetime_from_string(checkout) |> return_date()
    actual_return_datetime = datetime_from_string(return)

    days_late(planned_return_date, actual_return_datetime)
    |> days_late_fee(rate, monday?(actual_return_datetime))
  end

  defp days_to_return(datetime) do
    if(before_noon?(datetime), do: 28, else: 29)
  end

  @spec days_late_fee(
          days_late_count :: non_neg_integer(),
          rate :: non_neg_integer(),
          is_monday :: boolean()
        ) :: non_neg_integer()
  defp days_late_fee(0, _rate, _is_monday), do: 0
  defp days_late_fee(days_late_count, rate, true), do: trunc(days_late_count * rate * 0.5)
  defp days_late_fee(days_late_count, rate, false), do: days_late_count * rate
end
