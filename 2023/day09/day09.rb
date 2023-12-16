class Day09
  attr_reader :nums

  def initialize
    @nums = File.read('input.txt').split(/\n/).map { |line| line.scan(/-?\d+/).map(&:to_i) }
  end

  def part_1
    nums.sum { |ns| pascal(ns).sum(&:last) }
  end

  def part_2
    nums.sum { |ns| pascal(ns).map(&:first).reverse.reduce { _2 - _1 } }
  end

  def pascal arr
    p = [arr]
    until p.last.all?(&:zero?)
      p << p.last.each_cons(2).map { _2 - _1 }
    end

    p
  end
end
