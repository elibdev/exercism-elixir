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
                  test group_desc <> " > " <> test_case["description"] do
                    assert false
                  end
                end

              %{"property" => "abs"} = test_case ->
                test test_case["description"] do
                  input = unquote(test_case["input"]["r"])
                  expected = unquote(test_case["expected"])
                  assert RationalNumbers.calculate("abs", input) == expected
                end

              _ ->
                test test_case["description"] do
                  assert false
                end
            end
          end
        end
    end
  end
end
