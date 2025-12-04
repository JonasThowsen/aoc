defmodule DayOne do
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

    IO.puts("Final dial: #{final_dial}")
    IO.puts("Times pointing at 0: #{times_at_zero}")
  end

  defp apply_turn(dial, "L", clicks) do
    Integer.mod(dial - clicks, @modulus)
  end

  defp apply_turn(dial, "R", clicks) do
    Integer.mod(dial + clicks, @modulus)
  end
end

DayOne.run()
