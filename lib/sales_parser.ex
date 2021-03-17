defmodule SalesParser do
  def run do
    File.stream!("./lib/sales.txt")
    |> Stream.with_index()
    |> Stream.reject(fn ({_, i}) -> i == 0 end)
    |> Stream.map(fn {line, _i} ->
      [id, ship_to, net_amount] = String.split(line, ",")
      [
        id: String.to_integer(id),
        ship_to: String.to_atom(ship_to),
        net_amount: String.to_float(net_amount |> String.trim())
      ]
    end)
    |> Enum.to_list
  end
end
