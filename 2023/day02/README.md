# Day 2: Cube Conundrum

Identify impossible subsets

This is a classic data modeling problem. Each line of input represents a "game", where each game
has a unique identifier (game number), and a list of "hands". Each hand has a set of colored items.
A typical input line might look like this:

    Game 7: 4 red, 8 blue, 12 green; 10 green; 7 green, 4 blue, 10 red

My approach was to create a small Hand class that tokenized the chunks of input between semicolons,
and then generate an array of arrays containing game numbers and an array of Hand objects.

However, isolating each hand wasn't necessary to solve the problem. It is still solvable assuming
each game is one larger hand. My Hand class and splitting first on colons, then on semicolons could
just as well have been something like:

```
pairs = line.scan(/\w+/).each_slice(2) # an enumerator of pairs of word character blocks
game_num, games = [pairs.take(1), pairs.drop(1)]
# [[["Game", "7"]], [["4", "red"], ["8", "blue"]...]]
games.map { |n, c| [n.to_i, c] }.group_by(&:last).map { |c, a| [c, a.max.first] }
# [["red", 10], ["blue", 8], ["green", 12]]
```

...which is all that is needed to solve both parts of the day's puzzle. If I were actively trying
for Advent's leaderboard, I'd go for solutions that were more streamlined and mechanical like the
above. But I prefer having a good model to reference - `hands.map(&:green).max` is a pretty handy
idiom to use in a puzzle like this.

## Part 1

Given the counts of items in a set...

* For each line of input, extract an ID and a list of subsets
* Select IDs of lines with no impossible subsets
* Sum those IDs

## Part 2

* For each line of input:
  - Identify the minimum set to make all that line's subsets possible
  - Return the product of counts of each item in the minimum set
* Sum the products
