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

  describe '#update_current_cell_to' do
    let(:new_cell) do
      generated_cell = cell
      while generated_cell == cell
        cells_row = cells[(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample]
        generated_cell = cells_row[(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample]
      end

      generated_cell
    end

    before { piece.update_current_cell_to(new_cell) }

    it 'updates the current_cell to the new_cell' do
      expect(piece.current_cell).to eq(new_cell)
    end

    it 'occupies the new_cell' do
      expect(piece.current_cell.occupant).to be(piece)
    end

    it 'free the old cell' do
      expect(cell.occupant).to be_nil
    end

    it 'populates the cells_history with the old cell' do
      expect(piece.instance_variable_get(:@cells_history)).to include(cell)
    end
  end
end
