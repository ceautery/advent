class Day03
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    matches = scan_lines_with_positions(/\d+/)
    symbols = scan_lines_with_positions(/[^.\d]/)

    matches.select do |m|
      symbols.any? { |s| s[:x].between?(m[:x]-1, m[:x] + m[:str].size) && s[:y].between?(m[:y] - 1, m[:y] + 1) }
    end
      .sum { |m| m[:str].to_i }
  end

  def part_2
    matches = scan_lines_with_positions(/\d+/)
    stars = scan_lines_with_positions(/\*/)

    connections = stars.map do |s|
      matches.select { |m| s[:x].between?(m[:x]-1, m[:x] + m[:str].size) && s[:y].between?(m[:y] - 1, m[:y] + 1) }
    end

    connections.select { |c| c.size == 2 }.sum { |c| c[0][:str].to_i * c[1][:str].to_i }
  end

  def scan_lines_with_positions re
    lines.each_with_index.map do |line, line_num|
      # Ruby peculiarity, this is the easiest way to collect MatchData objects during a scan
      line.to_enum(:scan, re).map { Regexp.last_match }
        .map { |md| { x: md.begin(0), y: line_num, str: md.to_s } }
    end
      .flatten
  end
end
