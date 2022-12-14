defmodule ResistorColorTest do
  use ExUnit.Case

  describe "color codes" do
    # @tag :pending
    test "returns black color code" do
      assert ResistorColor.code(:black) == 0
      assert ResistorColor.code("black") == 0
    end

    # @tag :pending
    test "returns brown color code" do
      assert ResistorColor.code(:brown) == 1
      assert ResistorColor.code("brown") == 1
    end

    # @tag :pending
    test "returns red color code" do
      assert ResistorColor.code(:red) == 2
      assert ResistorColor.code("red") == 2
    end

    # @tag :pending
    test "returns orange color code" do
      assert ResistorColor.code(:orange) == 3
      assert ResistorColor.code("orange") == 3
    end

    # @tag :pending
    test "returns yellow color code" do
      assert ResistorColor.code(:yellow) == 4
      assert ResistorColor.code("yellow") == 4
    end

    # @tag :pending
    test "returns green color code" do
      assert ResistorColor.code(:green) == 5
      assert ResistorColor.code("green") == 5
    end

    # @tag :pending
    test "returns blue color code" do
      assert ResistorColor.code(:blue) == 6
      assert ResistorColor.code("blue") == 6
    end

    # @tag :pending
    test "returns violet color code" do
      assert ResistorColor.code(:violet) == 7
      assert ResistorColor.code("violet") == 7
    end

    # @tag :pending
    test "returns grey color code" do
      assert ResistorColor.code(:grey) == 8
      assert ResistorColor.code("grey") == 8
    end

    # @tag :pending
    test "returns white color code" do
      assert ResistorColor.code(:white) == 9
    end
  end

  # describe "list of colors" do
  #   # @tag :pending
  #   test "returns the list of colors" do
  #     assert ResistorColor.colors() == [
  #              "black",
  #              "brown",
  #              "red",
  #              "orange",
  #              "yellow",
  #              "green",
  #              "blue",
  #              "violet",
  #              "grey",
  #              "white"
  #            ]
  #   end
  # end
end
