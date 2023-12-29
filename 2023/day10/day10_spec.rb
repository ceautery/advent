require 'rspec'
require_relative 'day10'

RSpec.describe Day10 do
  subject(:day) { described_class.new }

  context '#part_1' do
    describe 'example 1' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          .....
          .S-7.
          .|.|.
          .L-J.
          .....
        EOF
      end

      it 'returns 4' do
        expect(day.part_1).to eq(4)
      end
    end

    describe 'example 2' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          ..F7.
          .FJ|.
          SJ.L7
          |F--J
          LJ...
        EOF
      end

      it 'returns 8' do
        expect(day.part_1).to eq(8)
      end
    end
  end

  context '#part_2' do
    describe 'example 1' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          ...........
          .S-------7.
          .|F-----7|.
          .||.....||.
          .||.....||.
          .|L-7.F-J|.
          .|..|.|..|.
          .L--J.L--J.
          ...........
        EOF
      end

      it 'returns 4' do
        expect(day.part_2).to eq(4)
      end
    end

    describe 'example 2' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          .F----7F7F7F7F-7....
          .|F--7||||||||FJ....
          .||.FJ||||||||L7....
          FJL7L7LJLJ||LJ.L-7..
          L--J.L7...LJS7F-7L7.
          ....F-J..F7FJ|L7L7L7
          ....L7.F7||L7|.L7L7|
          .....|FJLJ|FJ|F7|.LJ
          ....FJL-7.||.||||...
          ....L---J.LJ.LJLJ...
        EOF
      end

      it 'returns 8' do
        expect(day.part_2).to eq(8)
      end
    end

    describe 'edge case, pipe outside of main loop' do
      before do
        allow(File).to receive(:read).and_return <<~EOF
          .|F--7|.
          .|S..||.
          ..|..||.
          .||..||.
          .|L--J|.
        EOF
      end

      it 'returns 6' do
        expect(day.part_2).to eq(6)
      end
    end
  end
end
