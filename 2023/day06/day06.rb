class Day06
  attr_reader :lines

  def initialize
    @lines = File.read('input.txt').chomp.split(/\n/)
  end

  def wincount(t, d) # time and distance
    range = (0..t)

    # Find first element where speed s * remaining milliseconds exceeds record distance
    first_win = range.bsearch { |s| s * (t - s) > d }

    # Subtract twice that (outcomes on the left and right of the win range) from the total possibilities, for the number of wins
    range.size - 2 * first_win
  end

  def part_1
    times = lines[0].scan(/\d+/).map(&:to_i)
    distances = lines[1].scan(/\d+/).map(&:to_i)
    races = times.zip(distances)
    races.map { |t, d| wincount(t, d) }.reduce(:*)
  end

  def part_2
    time = lines[0].scan(/\d+/).join.to_i
    distance = lines[1].scan(/\d+/).join.to_i
    wincount(time, distance)
  end
end
