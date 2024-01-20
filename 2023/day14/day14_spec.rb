require 'rspec'
require_relative 'day14'

RSpec.describe Day14 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      O....#....
      O.OO#....#
      .....##...
      OO.#O....O
      .O.....O#.
      O.#..O.#.#
      ..O..#O..O
      .......O..
      #....###..
      #OO..#....
    EOF
  end

  context '#part_1' do
    it 'returns 136' do
      expect(day.part_1).to eq(136)
    end
  end

  context '#part_2' do
    it 'returns 64' do
      expect(day.part_2).to eq(64)
    end
  end
end
