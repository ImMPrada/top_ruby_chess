require 'spec_helper'
require 'chess/core/pieces/base_piece'
require 'chess/core/cell'

RSpec.describe Chess::Core::Pieces::BasePiece do
  subject(:piece) do
    described_class.create_and_occupy(%i[R N B Q K P].sample, [Chess::WHITE_TEAM, Chess::BLACK_TEAM].sample, cell)
  end

  let(:cells) do
    cells = []

    8.times do |row_index|
      cells << []
      8.times do |column_index|
        name = "#{%w[a b c d e f g h][column_index]}#{row_index + 1}"
        cells[row_index] << Chess::Core::Cell.new(name, Chess::WHITE_TEAM)
      end
    end

    cells
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
      generated_cell = cell
      while generated_cell == cell
        cells_row = cells[(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample]
        generated_cell = cells_row[(Chess::MIN_INDEX..Chess::MAX_INDEX).to_a.sample]
      end

      generated_cell
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
