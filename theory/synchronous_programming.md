## Using iex
    - h Enum.map
    - i "blah"
    - flush
    - c (executes *.exs, compiles *.ex)
## Pattern matching
[1, _, _] = [1, 2, 3] SUCCESS
[a] = [1, 2] FAIL

a = 2
^a = 1 - using existing variable in a pattern
## Types
Value types:
Arbitrary-sized integers
Floating-point numbers
Atoms (name is it's value)
Ranges (not really, just a structure)
Regular expressions (not really, just a structure)

System types:
PIDs and ports
References

Collection types:
Tuples  (A tuple is an ordered collection of values. Fixed size.)
Lists (Linked list structure)
Keyword List (List of key-value pairs - used only for passing options)
Maps (Collection of key-value pairs)
Binaries

Elixir doesn't have String type! Built from the list

## Regular expressions
iex> Regex.run ~r{[aeiou]}, "caterpillar" ["a"]
iex> Regex.scan ~r{[aeiou]}, "caterpillar" [["a"], ["e"], ["i"], ["a"]]
iex> Regex.split ~r{[aeiou]}, "caterpillar"
["c", "t", "rp", "ll", "r"]
iex> Regex.replace ~r{[aeiou]}, "caterpillar", "*" "c*t*rp*ll*r"


## Pattern matching in function definition

     warning: definitions with multiple clauses and default values require a
     function head. Instead of this:
         def foo(:first_clause, b \\ :default) do ... end
         def foo(:second_clause, b) do ... end
     one should write this:
         def foo(a, b \\ :default)
         def foo(:first_clause, b) do ... end
         def foo(:second_clause, b) do ... end

## What programming is...?
Programming is transforming data (at least backend. UI is about state)

## code reuse
import - all methods, or [:only, :except]
alias - SomeModule, as: NewName
require - to import macros

## Structs
Same as Maps, but keys always atoms

## Single quoted string
Just a list of character codes (1 million Unicode codepoints)

## Binary
Just a sequence of bits

## Double quoted string. Generally String = Binary in documentation
A binary with bytes in UTF-8 encoding.
Some UTF-8 characters take more than a single byte to represent.