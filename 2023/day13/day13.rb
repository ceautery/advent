class Day13
  attr_reader :grids

  def initialize
    @grids = File.read('input.txt').chomp.split(/\n\n/).map { |g| g.split(/\n/) }
  end


  def part_1
    grids.sum do |grid|
      idx = mirror_index(grid)
      if idx.nil?
        transposed = grid.map(&:chars).transpose.map(&:join)

        mirror_index(transposed)
      else
        idx * 100
      end
    end
  end

  def part_2
    grids.sum do |grid|
      idx = smudge_index(grid)
      if idx.nil?
        transposed = grid.map(&:chars).transpose.map(&:join)

        smudge_index(transposed)
      else
        idx * 100
      end
    end
  end

  def mirror_index(grid)
    matches = grid.each_cons(2).each_with_index.select { |p, i| p[0] == p[1] }.map { |_, m| m + 1 }
    matches.find do |m|
      pairs = grid.take(m).reverse.zip(grid.drop(m)).reject { |p| p.any?(&:nil?) }
      pairs.all? { |l1, l2| l1 == l2 }
    end
  end

  def smudge_index(grid)
    matches = grid.each_cons(2).each_with_index.select { |p, i| ham(p[0], p[1]) < 2 }.map { |_, m| m + 1 }
    matches.find do |m|
      pairs = grid.take(m).reverse.zip(grid.drop(m)).reject { |p| p.any?(&:nil?) }
      pairs.sum { |l1, l2| ham(l1, l2) } == 1
    end
  end

  def ham(s1, s2)
    s1.chars.zip(s2.chars).count { |c1, c2| c1 != c2 }
  end
end
