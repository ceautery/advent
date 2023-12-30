class Day02
  attr_reader :lines, :games

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)

    @games = lines.map do |line|
      left, right = line.split(':')
      game_num = left.match(/\d+/).to_s

      hands = right.split(';').map { |hand| Hand.new(hand) }
      [game_num, hands]
    end
  end


  def part_1
    games
      .select { |_, hands| hands.all? { |g| g.red <= 12 && g.green <= 13 && g.blue <= 14 } }
      .sum { |game_num, _| game_num.to_i }
  end

  def part_2
    games.sum do |_, hands|
      hands.map(&:red).max * hands.map(&:green).max * hands.map(&:blue).max
    end
  end
end

class Hand
  attr_reader :red, :green, :blue

  def initialize(str)
    counts = str.scan(/(\d+) (\w+)/).map { |g| [g[1], g[0].to_i] }.to_h
    @red = counts['red'] || 0
    @green = counts['green'] || 0
    @blue = counts['blue'] || 0
  end
end
