defmodule PatternMatch do
  def match? do
    # variable a is bound to the value 2

    # no match, because a, a = 1, 3
    [a, b, a] = [1, 2, 3]
    # no match because a, a = 1, 2
    [a, b, a] = [1, 1, 2]
    # match because it's assignment
    a = 1
    # no match because 1 != 2
    ^a = 2
    # match
    ^a = 1
    # match because 1 = 2 - 1
    ^a = 2 - a
  end
end
