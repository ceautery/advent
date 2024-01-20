require 'rspec'
require_relative 'day15'

RSpec.describe Day15 do
  subject(:day) { described_class.new }

  before do
    allow(File).to receive(:read).and_return <<~EOF
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    EOF
  end

  context '#part_1' do
    it 'returns 1320' do
      expect(day.part_1).to eq(1320)
    end
  end

  context '#part_2' do
    it 'returns 145' do
      expect(day.part_2).to eq(145)
    end
  end
end
