require 'rspec'
require_relative 'day09'

RSpec.describe Day09 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    EOF
  end

  context '#part_1' do
    it 'return 114' do
      expect(day.part_1).to eq(114)
    end
  end

  context '#part_2' do
    it 'return 2' do
      expect(day.part_2).to eq(2)
    end
  end
end
