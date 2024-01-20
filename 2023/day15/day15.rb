class Day15
  attr_reader :sequence

  def initialize
    @sequence = File.read('input.txt').chomp.chomp.split(',')
  end

  def hash(str)
    str.codepoints.reduce(0) { |acc, n| ((acc + n) * 17) % 256 }
  end

  def part_1
    sequence.sum { |step| hash(step) }
  end

  def part_2
    boxes = Array.new(256) { [] }

    sequence.each do |step|
      label, instruction, power = step.match(/([a-z]+)([=-])(\d*)/).captures

      box = boxes[hash(label)]

      case instruction
      when '='
        lens = box.find { |lens| lens[:label] == label }

        if lens.nil?
          box.push({ label: label, power: power})
        else
          lens[:power] = power
        end
      when '-'
        box.delete(box.find { |lens| lens[:label] == label })
      end
    end

    boxes.each.with_index(1).map do |box, box_num|
      box.each.with_index(1).map { |lens, slot_num| box_num * slot_num * lens[:power].to_i }
    end
      .flatten.sum
  end
end
