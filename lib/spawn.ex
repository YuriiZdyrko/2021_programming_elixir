defmodule Spawn do
  def greet do
    receive do
      {:hello, pid} ->
        send(pid, {:hello_back, "callback value"})
        IO.puts("hello")
        greet()
      {:yo, _pid} ->
        IO.puts("yo")
        # code
    end
  end

  def run do
    p = spawn(Spawn, :greet, [])
    send(p, {:hello, self()})

    receive do
      {:hello_back, value} ->
        IO.puts("received #{value}")
    end
  end
end
