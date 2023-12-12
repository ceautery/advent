require 'rspec'
require 'pry'
require_relative 'day03'

RSpec.describe Day03 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    EOF
  end

  context '#part_1' do
    it 'returns 4361' do
      expect(day.part_1).to eq(4361)
    end
  end

  context '#part_2' do
    it 'returns 467835' do
      expect(day.part_2).to eq(467835)
    end
  end
end
