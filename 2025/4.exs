defmodule Day4 do
  def part1() do
    grid = parse_grid("./day4input")

    result =
      grid
      |> Enum.filter(fn {_pos, char} -> char == "@" end)
      |> Enum.count(fn {pos, _char} -> accessible?(grid, pos) end)

    IO.puts("Part 1: #{result}")
  end

  def part2() do
    grid = parse_grid("./day4input")

    rolls =
      grid
      |> Enum.count(fn {_pos, char} -> char == "@" end)

    final_grid = remove_all_accessible(grid)

    remaining_rolls =
      final_grid
      |> Enum.count(fn {_pos, char} -> char == "@" end)

    result = rolls - remaining_rolls
    IO.puts("Part 2: #{result}")
  end

  defp parse_grid(filename) do
    File.stream!(filename)
    |> Stream.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.trim()
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, col} -> {{row, col}, char} end)
    end)
    |> Map.new()
  end

  defp get_cell(grid, pos) do
    Map.get(grid, pos, ".")
  end

  defp accessible?(grid, {row, col}) do
    neighbors = [
      {row - 1, col - 1},
      {row - 1, col},
      {row - 1, col + 1},
      {row, col - 1},
      {row, col + 1},
      {row + 1, col - 1},
      {row + 1, col},
      {row + 1, col + 1}
    ]

    count =
      neighbors
      |> Enum.count(fn pos -> get_cell(grid, pos) == "@" end)

    count < 4
  end

  defp remove_all_accessible(grid) do
    to_remove =
      grid
      |> Enum.filter(fn {pos, char} -> char == "@" and accessible?(grid, pos) end)
      |> Enum.map(fn {pos, _char} -> pos end)

    if Enum.empty?(to_remove) do
      grid
    else
      new_grid =
        Enum.reduce(to_remove, grid, fn pos, acc_grid ->
          Map.put(acc_grid, pos, ".")
        end)

      remove_all_accessible(new_grid)
    end
  end
end

Day4.part1()
Day4.part2()
