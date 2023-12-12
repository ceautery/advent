class Day03
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    matches = scan_lines_with_positions(/\d+/)
    symbols = scan_lines_with_positions(/[^.\d]/)

    matches.select do |m|
      symbols.any? { |s| s[:x].between?(m[:x]-1, m[:x] + m[:m].size) && s[:y].between?(m[:y] - 1, m[:y] + 1) }
    end
      .sum { |m| m[:m].to_i }
  end

  def part_2
    matches = scan_lines_with_positions(/\d+/)
    stars = scan_lines_with_positions(/\*/)

    connections = stars.map do |s|
      matches.select { |m| s[:x].between?(m[:x]-1, m[:x] + m[:m].size) && s[:y].between?(m[:y] - 1, m[:y] + 1) }
    end

    connections.select { |c| c.size == 2 }.sum { |c| c[0][:m].to_i * c[1][:m].to_i }
  end

  def scan_lines_with_positions re
    lines.each_with_index.map do |line, line_num|
      match = line.enum_for(:scan, re).map { |m| { x: Regexp.last_match.begin(0), y: line_num, m: m } }
    end
      .flatten
  end
end
