class Day12
  attr_reader :lines, :cache

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)

    # Part 2 is non-trivial, so we should cache sub-results
    # Keys are (substring we're looking at)-(goals we're still trying to solve for)
    # So when we get to the end of the string, and are done solving for goals, we get a point
    @cache = { '-' => 1 }
  end

  def part_1
    # brute_force(lines)
    dynamic(lines)
  end

  def part_2
    dynamic(unfold)
  end

  def unfold
    lines.map { |line| line.sub(/(.+) (.+)/, '\1?\1?\1?\1?\1 \2,\2,\2,\2,\2') }
  end

  def dynamic(ls)
    i = 0
    ls.sum do |line|
      i += 1
      input, pattern = line.split(' ')
      goal = pattern.split(',').map(&:to_i)

      dp(str: input, goal: goal)
    end
  end

  # This is a rewrite of my third attack on the problem. I didn't save that method, but it was
  # tracking too many variables to make use of a cache. I'm essentially following
  # [HyperNeutrino's approach](https://www.youtube.com/watch?v=g3Ms5e7Jdqo), substituting some
  # things that are easy in python with similar ruby-isms.
  #
  # That led me to this lovely landmine of a difference between python and ruby:
  # In python, 'test'[:1] returns 't'
  # In ruby, 'test'[..1] returns 'te'
  #
  # ...hence my regular expression zero-width lookbehind insanity with String#partition
  def dp(str: '', goal: [])
    key = "#{str}-#{goal.join(',')}"
    return cache[key] if cache.include?(key)

    # Empty strings with no remaining goals are filtered out by the initial cache entry
    # Empty strings when there are still goals are zero points
    return 0 if str.empty?

    # On no remaining goals, we get a point only if there are no more known springs
    if goal.empty?
      return str.include?('#') ? 0 : 1
    end

    # No points if we have need more # than the string can hold
    return 0 if goal.first > str.length

    count = 0

    # I'm manhandling String#partition here to return a string with the same length as the current
    # goal, the next letter (to see if the run of springs has a valid separator), and the remainder
    # of the string. We're using one ugly regex instead of three hard to read substring references
    re = Regexp.new("(?<=.{#{goal.first}}).")
    fill, post, rest = str.partition(re)

    # Dots call dp again one position further in the string with the same goals.
    # Hashes see if a complete run of springs can be placed from the current position.
    # Question marks do both.
    count += dp(str: str[1..], goal: goal)  if str =~ /^[.?]/
    count += dp(str: rest, goal: goal[1..]) if str =~ /^[#?]/ && fill !~ /\./ && post != '#'

    cache[key] = count
    count
  end

  # This was my second attempt at the puzzle, taking a slightly less naive approach than building
  # up each possible substring. This leverages a bit-twiddling hack to iterate through each
  # variation of numbers with the same number of binary 1 bits, and swapping the ones and zeroes
  # for # and . characters.
  #
  # This was much faster than my initial O(n^2) approach, but it was no match for part 2.
  def brute_force(ls)
    ls.sum do |line|
      input, pattern = line.split(' ')
      goal = pattern.split(',').map(&:to_i)

      n = input.count('?')
      k = goal.sum - input.count('#')

      combos(n, k).count do |r|
        e = r.to_enum
        lengths = input
          .gsub('?') { e.next }
          .split(/\.+/)
          .reject(&:empty?)
          .map(&:length)

        lengths == goal
      end
    end
  end

  def fact(n)
    Math.gamma(n + 1)
  end

  def take(n, k)
    fact(n) / (fact(k) * fact(n - k))
  end

  def nbp(v)
    # from https://graphics.stanford.edu/~seander/bithacks.html#NextBitPermutation
    t = (v | (v - 1)) + 1
    t | ((((t & -t) / (v & -v)) >> 1) - 1)
  end

  def to_pattern(len, n)
    sprintf("%0#{len}b", n).tr('01', '.#').chars
  end

  def combos(n, k)
    len = take(n, k)

    raise "Permutations to consider too high: #{len}" if len > 50_000

    arr = [2 ** k - 1]
    arr << nbp(arr.last) until arr.length == len

    arr.map { |i| to_pattern(n, i) }
  end
end
