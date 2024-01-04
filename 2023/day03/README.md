# Day 3: Gear Ratios

Find numbers on a grid adjacent to symbols.

    ..*34..23..
    12..56..*45
    .78.$....67
    .89...17..*

Presented with a text grid containing numbers and symbols (discounting periods), find all the
numbers that are touching a symbol, orthogonally or diagonally.

This is the first puzzle of the year requiring us to consider data from other lines. I iterated
over each line with an `each_with_index` to get my Y position on the grid, and used regex match
positions to identify X positions.

I also did something peculiar with regular expressions to solve a problem both ruby and javascript
share: finding all positions of matches from a single global regex. In ruby, `String#match` returns
a single MatchData object. You can use that to find the last offset, to know where to start the
next match, but that's a little clunky. `String#scan` on the other hand returns a simple array of
the string matches.

A common but hard to follow (at first) ruby idiom is to call `String.enum_for` or `String.to_enum`,
pass it the `:scan` symbol and a regular expression, and map over the results. I hope in the future
ruby provides a cleaner way to do that.

## Part 1

Sum all the numbers touching any symbol. In the example, only 78, 89, and 17
aren't touching a symbol, so we sum the others:

    12 + 23 + 34 + 45 + 56 + 67 = 237

## Part 2

Find asterisks touching exactly two numbers. Multiply each pair of numbers to make "gear ratios",
and sum all the ratios. In the example, there are three asterisks, but only two of them touch two
numbers. The connected pairs are 12 with 34, and 23 with 45.

    (12 * 34) + (23 * 45) = 1443

