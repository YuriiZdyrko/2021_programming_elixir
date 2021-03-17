defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send(next_pid, n + 1)
    end
  end

  def create_process(next_pid) do
    spawn(Chain, :counter, [next_pid])
  end

  def create_processes(n) do
    last_pid = 1..n
    |> Enum.reduce(self(), fn (_i, send_to) ->
      create_process(send_to)
    end)

    send(last_pid, 0)

    receive do
      n ->
        IO.puts("root_pid received count #{n}")
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n]) |> IO.inspect
  end
end
