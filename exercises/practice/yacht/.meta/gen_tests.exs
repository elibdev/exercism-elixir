# Generate tests.toml file from canonical-data.json
# $ mix run .meta/gen_tests.exs priv/canonical-data.json test/yach_test.exs

Mix.install([{:jason, "~> 1.2"}])

args = System.argv()

if length(args) != 2 do
  IO.puts("""
  This script requires two positional arguments:

  1. the path to the `canonical-data.json` file to read the tests from
  2. the path to the `test/yacht_test.exs` file to write to

  $ elixir .meta/gen_tests.exs priv/canonical-data.json test/yach_test.exs
  """)

  System.halt(1)
end

[data_file, test_file] = args

cases =
  File.read!(data_file)
  |> Jason.decode!()
  |> Map.get("cases")

tests =
  Enum.map(cases, fn case ->
    category = case["input"]["category"]
    dice = case["input"]["dice"]
    expected = case["expected"]

    """
    @tag :pending
    test "#{case["description"]}" do
      assert Yacht.score("#{category}", #{inspect(dice)}) == #{expected}
    end
    """
  end)

test_module = """
defmodule YachtTest do
  use ExUnit.Case

#{Enum.join(tests, "\n")}
end
"""

File.write!(test_file, test_module)
