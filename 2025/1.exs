defmodule DayOnePart1 do
  @modulus 100

  def run() do
    {final_dial, times_at_zero} =
      File.stream!("./day1input")
      |> Enum.reduce({50, 0}, fn line, {dial, count} ->
        line = String.trim(line)
        {dir, clicks_str} = String.next_grapheme(line)
        clicks = String.to_integer(clicks_str)

        new_dial = apply_turn(dial, dir, clicks)
        new_count = if new_dial == 0, do: count + 1, else: count
        {new_dial, new_count}
      end)

    IO.puts("Part 1:")
    IO.puts("Final dial: #{final_dial}")
    IO.puts("Times pointing at 0 after rotations: #{times_at_zero}")
  end

  defp apply_turn(dial, "L", clicks) do
    Integer.mod(dial - clicks, @modulus)
  end

  defp apply_turn(dial, "R", clicks) do
    Integer.mod(dial + clicks, @modulus)
  end
end

DayOnePart1.run()

defmodule DayOnePart2 do
  @modulus 100

  def run() do
    {final_dial, total_hits} =
      File.stream!("./day1input")
      |> Enum.reduce({50, 0}, fn line, {dial, count} ->
        line = String.trim(line)
        {dir, clicks_str} = String.next_grapheme(line)
        clicks = String.to_integer(clicks_str)

        {new_dial, hits} = apply_turn(dial, dir, clicks)
        {new_dial, count + hits}
      end)

    IO.puts("Part 2:")
    IO.puts("Final dial: #{final_dial}")
    IO.puts("Total hits on 0: #{total_hits}")
  end

  defp apply_turn(dial, _dir, 0), do: {dial, 0}

  defp apply_turn(dial, "L", clicks) do
    new_dial = Integer.mod(dial - 1, @modulus)
    hits = if new_dial == 0, do: 1, else: 0
    {final_dial, remaining_hits} = apply_turn(new_dial, "L", clicks - 1)
    {final_dial, hits + remaining_hits}
  end

  defp apply_turn(dial, "R", clicks) do
    new_dial = Integer.mod(dial + 1, @modulus)
    hits = if new_dial == 0, do: 1, else: 0
    {final_dial, remaining_hits} = apply_turn(new_dial, "R", clicks - 1)
    {final_dial, hits + remaining_hits}
  end
end

DayOnePart2.run()
