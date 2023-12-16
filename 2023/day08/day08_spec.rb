require 'rspec'
require_relative 'day08'

RSpec.describe Day08 do
  subject(:day) { described_class.new }

  context '#part_1' do
    describe 'example 1' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          RL

          AAA = (BBB, CCC)
          BBB = (DDD, EEE)
          CCC = (ZZZ, GGG)
          DDD = (DDD, DDD)
          EEE = (EEE, EEE)
          GGG = (GGG, GGG)
          ZZZ = (ZZZ, ZZZ)
        EOF
      end

      it 'returns 2' do
        expect(day.part_1).to eq(2)
      end
    end

    describe 'example 2' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          LLR

          AAA = (BBB, BBB)
          BBB = (AAA, ZZZ)
          ZZZ = (ZZZ, ZZZ)
        EOF
      end

      it 'returns 6' do
        expect(day.part_1).to eq(6)
      end
    end
  end

  context '#part_2' do
    before do
      allow(File).to receive(:read).and_return <<~EOF
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
      EOF
    end

      it 'returns 6' do
        expect(day.part_2).to eq(6)
      end
  end
end
