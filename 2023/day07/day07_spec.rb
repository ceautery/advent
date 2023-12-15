require 'rspec'
require_relative 'day07'

RSpec.describe Day07 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    EOF
  end

  context '#part_1' do
    it 'returns 6440' do
      expect(day.part_1).to eq(6440)
    end
  end

  context '#part_2' do
    it 'returns 5905' do
      expect(day.part_2).to eq(5905)
    end
  end
end
