class Day11
  require 'pry'

  attr_reader :galaxies, :x_expands, :y_expands

  def initialize
    lines = File.read('input.txt').chomp.split(/\n/)
    @y_expands = lines.each_with_index.select { |line, _| !line.match? /#/ }.map { |_, ndx| ndx }
    @x_expands = (0...lines.first.length).select { |i| lines.all? { |line| line[i] == '.' } }

    @galaxies = lines.each_with_index.map do |line, y|
      line.to_enum(:scan, /#/).map { [Regexp.last_match.begin(0), y] }
    end
      .flatten(1)
      .compact
  end

  def dist(arr, limit, scale)
    base = arr.bsearch_index { |i| i > limit } || arr.length
    base * scale
  end

  def sum_deltas scale
    galaxies
      .map { |x, y| [x + dist(x_expands, x, scale), y + dist(y_expands, y, scale)] }
      .combination(2)
      .sum { |g1, g2| (g1[0] - g2[0]).abs + (g1[1] - g2[1]).abs }
  end

  def part_1
    # Make galaxies twice as far apart by adding one row/column
    sum_deltas 1
  end

  def part_2
    # Make galaxies a million times as far apart by adding 999,999 rows/columns
    sum_deltas 999_999
  end
end
