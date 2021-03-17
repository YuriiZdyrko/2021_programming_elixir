defmodule TwoProcesses do
  def process() do
    receive do
      {token, from_pid} ->
        send(from_pid, token)
    end
  end

  def run do
    process_1 = spawn(TwoProcesses, :process, [])
    process_2 = spawn(TwoProcesses, :process, [])

    send(process_1, {:token_1, self})
    send(process_2, {:token_2, self})

    receive do
      msg ->
        IO.puts("received #{msg} first time")
    end

    receive do
      msg ->
        IO.puts("received #{msg} second time")
    end
  end
end
