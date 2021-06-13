defmodule Yacht do
  @moduledoc """
  Documentation for `Yacht`.
  """

  def score("yacht", dice) do
    unique_dice = MapSet.size(MapSet.new(dice))

    case unique_dice do
      1 -> 50
      _ -> 0
    end
  end

  def score("ones", dice), do: score(1, dice)
  def score("twos", dice), do: score(2, dice)
  def score("threes", dice), do: score(3, dice)
  def score("fours", dice), do: score(4, dice)
  def score("fives", dice), do: score(5, dice)
  def score("sixes", dice), do: score(6, dice)

  def score(number, dice) when is_integer(number) do
    Enum.count(dice, &(&1 == number)) * number
  end

  def score("full house", dice) do
    full_house =
      Enum.frequencies(dice)
      |> Map.values()
      |> MapSet.new() ==
        MapSet.new([3, 2])

    if full_house do
      Enum.sum(dice)
    else
      0
    end
  end

  def score("four of a kind", dice) do
    frequencies =
      Enum.frequencies(dice)
      |> Enum.to_list()
      |> Enum.filter(fn {_, freq} -> freq >= 4 end)

    case frequencies do
      [{number, _freq}] ->
        number * 4

      _ ->
        0
    end
  end

  def score(_category, _dice) do
    -1
  end
end
