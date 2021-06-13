defmodule Mix.Tasks.GenTestsToml do
  @moduledoc "Generate tests.toml file from canonical-data.json"
  @shortdoc "Generate tests.toml file"
  use Mix.Task
  # $ mix gen_tests_toml priv/gen_tests_toml.exs priv/canonical-data.json .meta/tests.toml

  @impl Mix.Task
  def run(args) do
    shell = Mix.shell()

    if length(args) != 2 do
      shell.error("""
      This script requires two arguments: 

      1. the canonical-data.json path to read the tests from
      2. the tests.toml path to write to

      $ mix gen_tests_toml priv/canonical-data.json .meta/tests.toml
      """)

      System.halt(1)
    end

    [data_file, test_file] = args

    tests =
      File.read!(data_file)
      |> Jason.decode!()
      |> Map.get("cases")

    intro = """
    # This is an auto-generated file. Regular comments will be removed when this
    # file is regenerated. Regenerating will not touch any manually added keys,
    # so comments can be added in a "comment" key.

    """

    tests_toml =
      Enum.reduce(tests, intro, fn test, tests_toml ->
        uuid = test["uuid"]
        desc = test["description"]

        tests_toml <>
          """
          [#{uuid}]
          description = "#{desc}"

          """
      end)

    File.write!(test_file, tests_toml)
  end
end
