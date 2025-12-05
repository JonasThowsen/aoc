defmodule Day3Part1 do
  def run() do
    lists =
      File.stream!("./day3input")
      |> Enum.map(fn line ->
        String.trim(line)
        |> String.to_integer()
        |> Integer.digits()
      end)

    result =
      Enum.map(lists, fn list ->
        max_joltage =
          for i <- 0..(length(list) - 2),
              j <- (i + 1)..(length(list) - 1) do
            first_digit = Enum.at(list, i)
            second_digit = Enum.at(list, j)

            first_digit * 10 + second_digit
          end
          |> Enum.max()

        max_joltage
      end)

    IO.puts("Sum: #{Enum.sum(result)}")
    IO.inspect(result, charlists: :as_list)
  end
end

Day3Part1.run()
