require 'rspec'
require 'pry'
require_relative 'day02'

RSpec.describe Day02 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    EOF
  end

  context '#part_1' do
    it 'returns 8' do
      expect(day.part_1).to eq(8)
    end
  end

  context '#part_2' do
    it 'returns 2286' do
      expect(day.part_2).to eq(2286)
    end
  end
end
