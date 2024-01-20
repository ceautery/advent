require 'rspec'
require_relative 'day16'

RSpec.describe Day16 do
  before do
    # Disable pesky \ interpolation by putting single quotes around the heredoc name
    allow(File).to receive(:read).and_return <<~'EOF'
      .|...\....
      |.-.\.....
      .....|-...
      ........|.
      ..........
      .........\
      ..../.\\..
      .-.-/..|..
      .|....-|.\
      ..//.|....
    EOF
  end

  subject(:day) { described_class.new }

  context '#part_1' do
    it 'returns 46' do
      expect(day.part_1).to eq(46)
    end
  end

  context '#part_2' do
    it 'returns 51' do
      expect(day.part_2).to eq(51)
    end
  end
end
