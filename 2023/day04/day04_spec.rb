require 'rspec'
require_relative 'day04'

RSpec.describe Day04 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    EOF
  end

  context '#part_1' do
    it 'returns 13' do
      expect(day.part_1).to eq(13)
    end
  end

  context '#part_2' do
    it 'returns 30' do
      expect(day.part_2).to eq(30)
    end
  end
end
