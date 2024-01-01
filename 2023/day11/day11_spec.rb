require 'rspec'
require_relative 'day11'

RSpec.describe Day11 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
    EOF
  end

  describe '#part_1' do
    it 'returns 374 for part 1' do
      expect(day.part_1).to eq(374)
    end
  end

  context 'with part 2 examples at non-solution scales' do
    subject(:sum_deltas) { described_class.new.sum_deltas(scale) }

    describe 'at scale 9' do
      let(:scale) { 9 }

      it 'returns 1030' do
        expect(sum_deltas).to eq(1030)
      end
    end

    describe 'at scale 99' do
      let(:scale) { 99 }

      it 'returns 8410' do
        expect(sum_deltas).to eq(8410)
      end
    end
  end
end
