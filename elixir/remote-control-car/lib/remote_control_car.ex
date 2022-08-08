defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  defguardp is_battery_empty(struct) when struct.battery_percentage == 0

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car = %RemoteControlCar{}) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car = %RemoteControlCar{})
      when is_battery_empty(remote_car),
      do: "Battery empty"

  def display_battery(remote_car = %RemoteControlCar{}) do
    "Battery at #{remote_car.battery_percentage}%"
  end

  def drive(remote_car = %RemoteControlCar{})
      when is_battery_empty(remote_car),
      do: remote_car

  def drive(remote_car = %RemoteControlCar{}) do
    %{
      remote_car
      | battery_percentage: remote_car.battery_percentage - 1,
        distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end
end
