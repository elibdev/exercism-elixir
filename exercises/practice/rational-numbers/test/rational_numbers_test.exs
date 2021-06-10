defmodule RationalNumbersTest do
  use ExUnit.Case

  @data Application.app_dir(:rational_numbers, "priv/canonical-data.json")
        |> File.read!()
        |> Jason.decode!()

  for test_case <- @data["cases"] do
    case test_case do
      %{"cases" => test_cases} = test_case ->
        describe test_case["description"] <> " >" do
          for test_case <- test_cases do
            case test_case do
              %{"cases" => test_cases} = test_case ->
                group_desc = test_case["description"]

                for test_case <- test_cases do
                  case test_case do
                    %{"property" => "mul"} = test_case ->
                      test test_case["description"] <>
                             " > mul #{Jason.encode!(test_case["input"])}" do
                        r1 = unquote(test_case["input"]["r1"])
                        r2 = unquote(test_case["input"]["r2"])
                        expected = unquote(test_case["expected"])
                        assert RationalNumbers.calculate("mul", [r1, r2]) == expected
                      end

                    _ ->
                      test group_desc <> " > " <> test_case["description"] do
                        assert unquote(test_case["property"]) ==
                                 unquote(Map.keys(test_case["input"]))
                      end
                  end
                end

              %{"property" => "abs"} = test_case ->
                test test_case["description"] do
                  r = unquote(test_case["input"]["r"])
                  expected = unquote(test_case["expected"])
                  assert RationalNumbers.calculate("abs", r) == expected
                end

              _ ->
                test test_case["description"] do
                  assert unquote(test_case["property"]) == unquote(Map.keys(test_case["input"]))
                end
            end
          end
        end
    end
  end
end
