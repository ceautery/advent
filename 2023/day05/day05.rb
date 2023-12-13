class Day05
  attr_reader :data

  def initialize
    @data = File.read('input.txt').chomp
  end


  def part_1
    seed_line, *mapping_sections = data.split(/\n\n/)

    seeds = seed_line.scan(/\d+/).map(&:to_i)
    mappings = mapping_sections.map { |s| mapping s }

    seeds.map do |s|
      mappings.reduce(s) do |acc, ms|
        map = ms.find { |m| acc.between?(m[:start], m[:end]) }
        map.nil? ? acc : acc - map[:start] + map[:dest]
      end
    end
      .min
  end

  def part_2
    seed_line, *mapping_sections = data.split(/\n\n/)

    seeds = seed_line.scan(/\d+/).map(&:to_i).each_slice(2).map { |start, len| { start: start, end: start + len - 1 } }
    mappings = mapping_sections.map { |s| mapping s }

    seeds.map do |seed|
      mappings.reduce([seed]) do |acc, ms|
        acc.map { |s| split_seed(s, ms) }.flatten
      end
    end
      .flatten.map { |m| m[:start] }.min
  end

  def split_seed(seed, ms)
    overlaps = ms.select { |m| overlap?(seed, m) }.map do |m|
      offset = m[:dest] - m[:start]
      max_start = [seed[:start], m[:start]].max
      min_end = [seed[:end], m[:end]].min

      { start: max_start, end: min_end, offset: offset }
    end

    seeds = []
    overlaps.each do |o|
      # Oddly, this is only needed for the test data. The puzzle input has complete mapping coverage.
      seeds << { start: seed[:start], end: o[:start] - 1 } if seed[:start] < o[:start]

      seeds << { start: o[:start] + o[:offset], end: [seed[:end], o[:end]].min + o[:offset] }
      seed[:start] = o[:end] + 1
    end
    seeds << seed if seed[:start] <= seed[:end]

    seeds
  end

  def mapping str
    str.split(/\n/)[1..].map do |m|
      dest, start, len = m.scan(/\d+/).map(&:to_i)
      { dest: dest, start: start, end: start + len - 1 }
    end
      .sort_by { |m| m[:start] }
  end

  def overlap?(map_1, map_2)
    map_1[:start] <= map_2[:end] && map_2[:start] <= map_1[:end]
  end
end
