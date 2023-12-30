class Day03
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    matches = scan_lines_with_positions(/\d+/)
    symbols = scan_lines_with_positions(/[^.\d]/)

    matches
      .select { |m| symbols.any? { |s| m.near(s) } }
      .sum(&:num)
  end

  def part_2
    matches = scan_lines_with_positions(/\d+/)
    stars = scan_lines_with_positions(/\*/)

    stars
      .map { |s| matches.select { |m| m.near(s) } }
      .select { |c| c.size == 2 }.sum { |c| c.map(&:num).reduce(:*) }
  end

  def scan_lines_with_positions re
    lines.each_with_index.map do |line, line_num|
      line.to_enum(:scan, re).map { Match.new(Regexp.last_match, line_num) }
    end
      .flatten
  end
end

class Match
  attr_reader :x, :e, :y, :num

  def initialize md, line_num
    @x = md.begin(0)
    @e = md.end(0)
    @y = line_num
    @num = md.to_s.to_i
  end

  def near other
    other.x.between?(x - 1, e) && other.y.between?(y - 1, y + 1)
  end
end
