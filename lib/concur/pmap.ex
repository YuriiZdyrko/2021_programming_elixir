defmodule PMap do
  def pmap(list, func) do
    # Spawn n Processes, pass self() to each.
    # From each process, send to parent Process

    # In parent process, create n receive blocks.
    # Use ^worker_pid to make sure results arrive in same order as workers spawned.

    me = self()

    list
    |> Enum.map(fn index ->
      spawn(fn -> send(me, {self(), func.(index)}) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} ->
          IO.inspect(result)
      end
    end)
  end

  def run do
    list = 1..10
    func = fn i ->
      # :timer.sleep i * 100
      :timer.sleep 100
      "done #{i} done"
    end

    pmap(list, func)
  end
end
