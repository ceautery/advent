class Day14
  require 'digest'

  # attr_reader :lines, :scores
  attr_reader :grid

  BILLION = 1_000_000_000

  def initialize
    lines = File.read('input.txt').chomp.split(/\n/)
    @grid = lines.map(&:chars)

    # Naive approach for part_1. This doesn't actually move pieces, which is needed for part_2.
    # max = lines.length
    # shelf = lines.first.chars.map { |c| { c: c, v: max } }
    #
    # @scores = lines.each_with_index.map do |line, y|
    #   if y.zero?
    #     shelf.dup
    #   else
    #     line.chars.each_with_index.map do |c, x|
    #       sp = shelf[x]
    #       score = case sp[:c]
    #               when '.'
    #                 sp[:v]
    #               when 'O'
    #                 sp[:v] - 1
    #               when '#'
    #                 max - y
    #               end
    #       piece = { c: c, v: score }
    #       shelf[x] = piece
    #     end
    #   end
    # end
    #   .flatten

  end

  def move_grid_north
    (1...(grid.length)).each do |y|
      (0...(grid[y].length)).each do |x|
        next unless grid[y][x] == 'O'

        p = y
        p -= 1 while p.positive? && grid[p - 1][x] == '.'
        next if p == y

        grid[p][x] = grid[y][x]
        grid[y][x] = '.'
      end
    end
  end

  def move_grid_west
    (1...(grid.first.length)).each do |x|
      (0...(grid.length)).each do |y|
        next unless grid[y][x] == 'O'

        p = x
        p -= 1 while p.positive? && grid[y][p - 1] == '.'
        next if p == x

        grid[y][p] = grid[y][x]
        grid[y][x] = '.'
      end
    end
  end

  def move_grid_south
    bottom_row = grid.length - 1

    (bottom_row - 1).downto(0).each do |y|
      (0...(grid[y].length)).each do |x|
        next unless grid[y][x] == 'O'

        p = y
        p += 1 while p < bottom_row && grid[p + 1][x] == '.'
        next if p == y

        grid[p][x] = grid[y][x]
        grid[y][x] = '.'
      end
    end
  end

  def move_grid_east
    right_column = grid.first.length - 1

    (right_column - 1).downto(0).each do |x|
      (0...(grid.length)).each do |y|
        next unless grid[y][x] == 'O'

        p = x
        p += 1 while p < right_column && grid[y][p + 1] == '.'
        next if p == x

        grid[y][p] = grid[y][x]
        grid[y][x] = '.'
      end
    end
  end

  def score_grid
    max = grid.length
    grid.each_with_index.sum do |chars, y|
      chars.count('O') * (max - y)
    end
  end

  def grid_digest
    Digest::MD5.hexdigest(grid.map(&:join).join)
  end

  def print_grid
    puts grid.map(&:join)
  end

  def cycle_grid
    move_grid_north
    move_grid_west
    move_grid_south
    move_grid_east
  end

  def part_1
    # scores.select { |s| s[:c] == 'O' }.sum { |s| s[:v] }

    move_grid_north
    score_grid
  end

  def part_2
    grid_history = []
    digest = grid_digest

    until grid_history.include?(digest) do
      grid_history << digest
      cycle_grid
      digest = grid_digest
    end

    offset = grid_history.index(digest)
    cycle_length = grid_history.length - offset
    cycles_remaining = (BILLION - offset) % cycle_length

    cycles_remaining.times { cycle_grid }
    score_grid
  end
end
