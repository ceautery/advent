class Day16
  require 'set'

  H = [:east, :west]
  V = [:north, :south]

  attr_reader :grid, :max_y, :max_x

  def initialize
    @grid = File.read('input.txt').split(/\n/).compact.map do |line|
      line.chars.map { |c| Cell.new(c) }
    end

    @max_y = grid.length - 1
    @max_x = grid.first.length - 1
  end

  def oob(x, y)
    x < 0 || x > max_x || y < 0 || y > max_y
  end

  def path(x, y, dir)
    return if oob(x, y)

    cell = grid[y][x]
    cell.vectors.add?(dir) || return

    n = next_dir(dir, cell.char)

    if n.is_a? Array
      n.each { |d| next_path(x, y, d) }
    else
      next_path(x, y, n)
    end
  end

  def next_path(x, y, dir)
    case dir
    when :east
      path(x + 1, y, dir)
    when :south
      path(x, y + 1, dir)
    when :west
      path(x - 1, y, dir)
    else
      path(x, y - 1, dir)
    end
  end

  def next_dir(dir, char)
    return dir if char == '.'

    return dir if char == '|' && V.include?(dir)
    return dir if char == '-' && H.include?(dir)

    return (H.include?(dir) ? left(dir) : right(dir)) if char == '/'
    return (V.include?(dir) ? left(dir) : right(dir)) if char == '\\'

    [left(dir), right(dir)]
  end

  def left(dir)
    case dir
    when :east
      :north
    when :north
      :west
    when :west
      :south
    else
      :east
    end
  end

  def right(dir)
    case dir
    when :east
      :south
    when :south
      :west
    when :west
      :north
    else
      :east
    end
  end

  def new_path(x, y, dir)
    grid.flatten.each { |cell| cell.vectors.clear }
    path(x, y, dir)
    grid.flatten.count { |c| c.vectors.size.positive? }
  end

  def part_1
    new_path(0, 0, :east)
  end

  def part_2
    [
      (0..max_y).map { |y| new_path(0,     y,     :east) },
      (0..max_y).map { |y| new_path(max_x, y,     :west) },
      (0..max_x).map { |x| new_path(x,     0,     :south) },
      (0..max_x).map { |x| new_path(x,     max_y, :north) }
    ].flatten.max
  end
end

class Cell
  attr_reader :char, :vectors

  def initialize(char)
    @char = char
    @vectors = Set.new
  end
end
