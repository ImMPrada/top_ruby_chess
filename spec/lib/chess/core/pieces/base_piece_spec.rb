require 'spec_helper'

RSpec.describe Chess::Core::Pieces::BasePiece do
  subject(:piece) { described_class.new(%i[R N B Q K P], [Chess::WHITE_TEAM, Chess::BLACK_TEAM].sample, cell) }

  let(:cells) do
    cells = []

    8.times do |row_index|
      cells << []
      8.times do |column_index|
        name = "#{%w[a b c d e f g h][column_index]}#{row_index + 1}"
        cells[row_index] << Chess::Core::Cell.new(name, :white)
      end
    end

    cells
  end
  let(:cell) do
    cells[(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample][(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample]
  end

  describe '#initialize' do
    it 'initializes with a cell' do
      expect(piece.current_cell).to be_a Chess::Core::Cell
    end

    it 'occupies the current_cell' do
      expect(piece.current_cell.occupant).to be(piece)
    end
  end
end
