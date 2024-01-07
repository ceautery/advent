require 'rspec'
require_relative 'day12'

RSpec.describe Day12 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
    EOF
  end

  context '#part_1' do
    it 'returns 21' do
      expect(day.part_1).to eq(21)
    end
  end

  context '#part_2' do
    it 'returns 525152' do
      expect(day.part_2).to eq(525152)
    end
  end
end
