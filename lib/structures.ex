defmodule SquaredList do
  def run([head | tail]) do
    [head * head | run(tail)]
  end

  def run([]) do
    []
  end
end

defmodule MapSum do
  def run(fun, [head | tail]) do
    fun.(head) + run(fun, tail)
  end

  def run(_, []), do: 0
end

defmodule MaxList do
  def run([h | [hh | t]]), do: run([max(h, hh) | t])
  def run([h]), do: h
end

defmodule SwapList do
  def run([a, b | t]) do
    [b, a | run(t)]
  end

  def run([a]) do
    [a]
  end

  def run([]), do: []
end

defmodule ReverseList do
  def run([h | t]) do
    run(t) ++ [h]
  end

  def run([]) do
    []
  end
end

defmodule ListFromTo do
  def run(from, from), do: []

  def run(from, to) do
    [from | run(from + 1, to)]
  end
end

defmodule All do
  def run([h | t], fun) do
    fun.(h) && run(t, fun)
  end

  def run([], _), do: true
end

defmodule Filter do
  def run([], _), do: []

  def run([h | t], fun) do
    if fun.(h) do
      [h | run(t, fun)]
    else
      run(t, fun)
    end
  end
end

defmodule Split do
  def run(list, count) do
    {collect_front(list, count), collect_back(list, count)}
  end

  def collect_front(_, 0), do: []

  def collect_front([h | t], count) do
    [h | collect_front(t, count - 1)]
  end

  def collect_back(list, 0), do: list

  def collect_back([_h | t], count) do
    collect_back(t, count - 1)
  end
end

defmodule Flatten do
  def run([h | t]) when is_list(h), do: run(h) ++ run(t)

  def run([h | t]) do
    [h | run(t)]
  end

  def run([]), do: []
end
