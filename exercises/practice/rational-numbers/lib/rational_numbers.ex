defmodule RationalNumbers do
  @moduledoc """
  Documentation for `RationalNumbers`.
  """

  def calculate("abs", r) do
    Enum.map(r, fn n -> abs(n) end)
  end
  def calculate(_op, r) do
    r
  end
end
