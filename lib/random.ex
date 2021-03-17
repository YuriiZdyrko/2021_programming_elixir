defmodule Parallel do
  def pmap(collection, func) do
    collection |> Enum.map(&Task.async(fn -> func.(&1) end)) |> Enum.map(&Task.await/1)
  end
end

defmodule FizzBuzz do
  def run(a, b, c) do
    cond do
      a == 0 && b == 0 -> "FizBuzz"
      b == 0 -> "Buzz"
      true -> c
    end
  end
end

defmodule Curry do
  def run(str) do
    fn str2 ->
      str <> " " <> str2
    end
  end

  def test do
    f = Curry.run("Yura")
    f.("Zdyrko")
  end
end

defmodule FnRewrite do
  def run do
    # Enum.map [1,2,3,4], fn x -> x + 2 end
    Enum.map([1, 2, 3, 4], &(&1 + 2))
  end

  def run2 do
    # Enum.each [1,2,3,4], fn x -> IO.inspect x end
    Enum.each([1, 2, 3, 4], &IO.inspect(&1))
  end
end

defmodule Factorial do
  def run(1), do: 1
  def run(n), do: n * run(n - 1)
end

defmodule Length do
  def len([_]), do: 1
  def len([_ | t]), do: length(t) + 1
end

defmodule GCD do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts("#{x} is a number")
  end

  def what_is(x) when is_list(x) do
    IO.puts("#{inspect(x)} is a list")
  end

  def what_is(x) when is_atom(x) do
    IO.puts("#{x} is an atom")
  end
end

defmodule Guess do
  def guess(number, range) do
    max = Enum.max(range)
    min = Enum.min(range)
    pivot = min + div(max - min, 2)

    cond do
      number > pivot ->
        IO.inspect("gt")
        IO.inspect("#{pivot}..#{max}")
        :timer.sleep(1000)
        guess(number, pivot..max)

      number < pivot ->
        IO.inspect("lt")
        IO.inspect("#{min}..#{pivot}")
        :timer.sleep(1000)
        guess(number, min..pivot)

      true ->
        IO.inspect("found matching number")
    end
  end
end

defmodule CenterString do
  def run(strings) do
    max_len = strings
    |> Enum.map(&String.length(&1))
    |> Enum.max()

    strings
    |> Enum.map(fn str ->
      padding = div(max_len - String.length(str), 2)

      pad = String.duplicate(" ", padding)
      res = pad <> str <> pad

      IO.puts(res)
    end)
    nil
  end
end

defmodule CapitalizeString do
  def run(string) do
    string
    |> String.split(". ")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end
end
