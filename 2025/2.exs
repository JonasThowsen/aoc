defmodule Day2Part1 do
  def run() do
    result =
      File.read!("./day2input")
      |> String.trim()
      |> String.split(",")
      |> Enum.map(fn pair ->
        [a, b] = String.split(pair, "-")
        {String.to_integer(a), String.to_integer(b)}
      end)
      |> Enum.map_reduce(0, fn {first, second}, acc ->
        invalidId = find_invalid_ids(first, second)
        {invalidId, acc + invalidId}
      end)

    IO.inspect(result)
  end

  defp find_invalid_ids(first, second) do
    first..second
    |> Enum.filter(&is_invalid_id/1)
    |> Enum.sum()
  end

  defp is_invalid_id(num) do
    digits = Integer.to_string(num)
    len = String.length(digits)

    if rem(len, 2) == 0 do
      half = div(len, 2)
      first_half = String.slice(digits, 0, half)
      second_half = String.slice(digits, half, half)
      first_half == second_half
    else
      false
    end
  end
end

Day2Part1.run()

defmodule Day2Part2 do
  def run() do
    result =
      File.read!("./day2input")
      |> String.trim()
      |> String.split(",")
      |> Enum.map(fn pair ->
        [a, b] = String.split(pair, "-")
        {String.to_integer(a), String.to_integer(b)}
      end)
      |> Enum.map_reduce(0, fn {first, second}, acc ->
        invalidId = find_invalid_ids(first, second)
        {invalidId, acc + invalidId}
      end)

    IO.inspect(result)
  end

  defp find_invalid_ids(first, second) do
    first..second
    |> Enum.filter(&is_invalid_id/1)
    |> Enum.sum()
  end

  defp is_invalid_id(num) do
    digits = Integer.to_string(num)
    len = String.length(digits)

    if len < 2 do
      false
    else
      1..div(len, 2)
      |> Enum.any?(fn seq_len ->
        rem(len, seq_len) == 0 and
          is_repeating_sequence?(digits, seq_len)
      end)
    end
  end

  defp is_repeating_sequence?(digits, seq_len) do
    sequence = String.slice(digits, 0, seq_len)
    len = String.length(digits)
    repetitions = div(len, seq_len)

    repeated = String.duplicate(sequence, repetitions)
    repeated == digits
  end
end

Day2Part2.run()
