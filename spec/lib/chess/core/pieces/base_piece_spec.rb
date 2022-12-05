require 'spec_helper'
require 'chess/core/pieces/base_piece'
require 'chess/core/cell'
require 'chess/core/board'

RSpec.describe Chess::Core::Pieces::BasePiece do
  subject(:piece) do
    described_class.create_and_occupy(
      %i[R N B Q K P].sample,
      [Chess::Constants::WHITE_TEAM, Chess::Constants::BLACK_TEAM].sample,
      cell
    )
  end

  let(:board) { Chess::Core::Board.new }
  let(:cells) do
    board.generate_cells
    board.cells
  end
  let(:cell) { cells.sample.sample }

  describe '.create_and_occupy' do
    it 'initializes with a cell' do
      expect(piece.current_cell).to be_a Chess::Core::Cell
    end

    it 'occupies the current_cell' do
      expect(piece.current_cell.occupant).to be(piece)
    end
  end

  describe '#update_current_cell_to' do
    let(:new_cell) do
      random_cell = cell
      random_cell = cells.sample.sample while random_cell == cell

      random_cell
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

  describe '#roll_back_cell' do
    let(:new_cell) do
      random_cell = cell
      random_cell = cells.sample.sample while random_cell == cell

      random_cell
    end

    before do
      piece.update_current_cell_to(new_cell)
      piece.roll_back_cell
    end

    it 'updates the current_cell to the old cell' do
      expect(piece.current_cell).to eq(cell)
    end

    it 'free the new cell' do
      expect(new_cell.occupant).to be_nil
    end
  end
end
