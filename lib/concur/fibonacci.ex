defmodule Scheduler do
  @doc """
  1. Initialize n Solvers
  2. Wait for {:ready, pid} from Solvers
    a. Queue not empty
    - decrease queue size
    - give work to :ready Solver
    b. Queue empty
    - decrease processes counter
    - if (processes length === 0), return result

  3. Wait for {:answer, n, result}
    - put result into results


  So state of Scheduler = queue, solvers_running, result
  """
  def run do
    loop(
      spawn_solvers(3),
      [10, 20, 23, 15, 34, 35],
      []
    )
  end

  def loop(solvers, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        IO.inspect("QUEUE: #{length(queue)} | SOLVERS: #{length(solvers)}")
        [head | tail] = queue
        send(pid, {:fib, head})
        loop(solvers, tail, results)
      {:ready, pid}  ->
        IO.inspect("QUEUE: #{length(queue)} | SOLVERS: #{length(solvers)}")
        send(pid, {:shutdown}) # perform cleanup of Solver process
        solvers = List.delete(solvers, pid)
        if (length(solvers) > 0) do
          loop(solvers, queue, results)
        else
          IO.inspect("DONE")
          IO.inspect(results)
        end
      {:answer, result} ->
        loop(solvers, queue, results ++ [result])
    end
  end

  def spawn_solvers(n) do
    1..n
    |> Enum.map(fn _ ->
      spawn(Solver, :loop, [self()])
    end)
  end
end

defmodule Solver do
  def loop(scheduler_pid) do
    send(scheduler_pid, {:ready, self()})

    receive do
      {:fib, n} ->
        :timer.sleep(:random.uniform(100))
        send(scheduler_pid, {:answer, {n, calculate(n)}})
        loop(scheduler_pid)
      {:shutdown} ->
        exit(:normal)
    end
  end

  def calculate(0), do: 0
  def calculate(1), do: 1
  def calculate(n) do
    calculate(n - 1) + calculate(n - 2)
  end
end
