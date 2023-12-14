require 'rspec'
require_relative 'day06'

RSpec.describe Day06 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      Time:      7  15   30
      Distance:  9  40  200
    EOF
  end

  context '#part_1' do
    it 'returns 288' do
      expect(day.part_1).to eq(288)
    end
  end

  context '#part_2' do
    it 'returns 71503' do
      expect(day.part_2).to eq(71503)
    end
  end
end
