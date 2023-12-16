class Day08
  attr_reader :instructions, :nodes

  def initialize
    is, ns = File.read('input.txt').chomp.split(/\n\n/).map(&:chomp)

    @instructions = is.chars
    @nodes = ns.split(/\n/).map do |n|
      node = Node.new(n)
      [node.name, node]
    end
      .to_h
  end

  def part_1
    name = 'AAA'

    instructions.cycle.take_while do |i|
      node = nodes[name]
      name = i == 'L' ? node.left : node.right

      name != 'ZZZ'
    end
      .count + 1
  end

  def part_2
    names = nodes.keys.select { |k| k.end_with? 'A' }

    # The live answer is in the trillions, so we don't want to iterate through naively.
    # Instead, we'll find where each individual node path exits, and find the least common multiple of all of them
    #
    # This isn't guaranteed to work by the puzzle's description, but it does happen to work on my input,
    # and I assume this is intentional.
    counts = Array.new(names.length) { 0 }
    count = 0

    instructions.cycle.take_while do |i|
      count += 1
      ns = names.map { |n| nodes[n] }
      names = i == 'L' ? ns.map(&:left) : ns.map(&:right)
      names.each_with_index do |name, idx|
        counts[idx] = count if name.end_with?('Z') && counts[idx] == 0
      end

      counts.any?(&:zero?)
    end

    counts.reduce(1, :lcm)
  end
end

class Node
  attr_reader :name, :left, :right

  def initialize n
    @name, @left, @right = n.scan /\w+/
  end
end
