class Day01
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end


  def part_1
    lines.sum do |line|
      line.scan(/\d/).values_at(0, -1).join.to_i
    end
  end

  def part_2
    digits = %w(0 1 2 3 4 5 6 7 8 9 zero one two three four five six seven eight nine)
    re = Regexp.new "(?=(#{ digits.join('|') }))"

    lines.sum do |line|
      line.scan(re).flatten.values_at(0, -1).map { |v| digits.index(v) % 10 }.join.to_i
    end
  end
end
