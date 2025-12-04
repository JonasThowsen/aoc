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
        invalidId = check_rep_seq(first, second)
        {invalidId, acc + invalidId}
      end)

    IO.inspect(result)
  end

  defp check_rep_seq(first, second) do
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
