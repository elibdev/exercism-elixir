defmodule RationalNumbersTest do
  use ExUnit.Case

  @data Application.app_dir(:rational_numbers, "priv/canonical-data.json")
        |> File.read!()
        |> Jason.decode!()

  for case <- @data["cases"] do
    describe case["description"] do
      # run the tests that don't contain more cases
      # TODO: add logic to iterate over those tests as well
      for case <- case["cases"], !Map.has_key?(case, "cases") && case["property"] == "abs" do
        test case["description"] do
          input = unquote(case["input"]["r"])
          expected = unquote(case["expected"])
          assert RationalNumbers.calculate("abs", input) == expected
        end
      end
    end
  end
end
