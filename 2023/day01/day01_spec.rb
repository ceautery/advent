require 'rspec'
require 'pry'
require_relative 'day01'

RSpec.describe Day01 do
  subject(:day) { described_class.new }

  context '#part_1' do
    before do
      allow(File).to receive(:read).and_return <<~EOF
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
      EOF
    end

    it 'sums to 142' do
      expect(day.part_1).to eq(142)
    end
  end

  context '#part_2' do
    before do
      allow(File).to receive(:read).and_return <<~EOF
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      EOF
    end

    it 'sums to 281' do
      expect(day.part_2).to eq(281)
    end
  end

  context '#part_2 regex edge case' do
    before do
      allow(File).to receive(:read).and_return("3eightwo")
    end

    it 'sums to 32, not 38' do
      expect(subject.part_2).to eq(32)
    end
  end
end
