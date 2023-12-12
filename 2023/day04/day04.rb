class Day04
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    win_counts.select(&:positive?).map { |c| 2 ** (c - 1) }.sum
  end

  def part_2
    counts = Array.new(lines.length) { 1 }
    win_counts.each_with_index do |count, index|
      (index + 1..index + count).each { |i| counts[i] += counts[index] } if count.positive?
    end

    counts.sum
  end

  def win_counts
    lines.map do |line|
      winning, mine = line[line.index(':')..].split(/\|/).map { |str| str.scan /\d+/ }
      (winning & mine).length
    end
  end
end
