defmodule RationalNumbers do
  @moduledoc """
  Documentation for `RationalNumbers`.
  """

  def calculate("abs", r) do
    Enum.map(r, fn n -> abs(n) end)
  end

  def calculate("mul", [r1, r2]) do
    Enum.map([0, 1], fn i ->
      Enum.at(r1, i) * Enum.at(r2, i)
    end)
  end

  def calculate(_op, r) do
    r
  end
end
