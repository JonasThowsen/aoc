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

defmodule Day3Part2 do
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
        largest_k_digit_number(list, 12)
      end)

    IO.puts("Sum: #{Enum.sum(result)}")
    IO.inspect(result, charlists: :as_list)
  end

  def largest_k_digit_number(list, k) do
    n = length(list)
    select_digits(list, 0, n, k, [])
  end

  defp select_digits(_list, _start, _n, 0, acc) do
    acc
    |> Enum.reverse()
    |> Integer.undigits()
  end

  defp select_digits(list, start, n, remaining, acc) do
    search_end = n - remaining

    {max_digit, max_pos} =
      start..search_end
      |> Enum.map(fn pos -> {Enum.at(list, pos), pos} end)
      |> Enum.max_by(fn {digit, _pos} -> digit end)

    select_digits(list, max_pos + 1, n, remaining - 1, [max_digit | acc])
  end
end

Day3Part2.run()
