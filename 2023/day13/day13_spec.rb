require 'rspec'
require_relative 'day13'

RSpec.describe Day13 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
    EOF
  end

  context '#part_1' do
    it 'returns 405' do
      expect(day.part_1).to eq(405)
    end
  end

  context '#part_2' do
    it 'returns 400' do
      expect(day.part_2).to eq(400)
    end
  end
end
