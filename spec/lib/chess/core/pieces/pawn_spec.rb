require 'spec_helper'
require 'chess/core/pieces/pawn'
require 'chess/core/cell'
require 'chess/core/board'

RSpec.describe Chess::Core::Pieces::Pawn do
  subject(:pawn) { described_class.create_and_occupy(Chess::Core::Constants::WHITE_TEAM, cell_d2) }

  let(:board) { Chess::Core::Board.new }
  let(:cells) do
    board.generate_cells
    board.cells
  end
  let(:cell_d2) { cells[1][3] }

  describe '. create_and_occupy' do
    it 'occupies the cell' do
      expect(pawn.current_cell.occupant).to be(pawn)
    end
  end

  describe 'whit other pieces occupyng cells, and starting at d2' do
    let(:cell_d3) { cells[2][3] }
    let(:cell_d4) { cells[3][3] }
    let(:cell_d5) { cells[4][3] }
    let(:cell_e3) { cells[2][4] }

    before do
      described_class.create_and_occupy(Chess::Core::Constants::BLACK_TEAM, cell_e3)
    end

    describe '#can_move_to?' do
      it 'can move to d3 at first move' do
        expect(pawn.can_move_to?(cell_d3, cells)).to be(true)
      end

      it 'can move to d4 at first move' do
        expect(pawn.can_move_to?(cell_d4, cells)).to be(true)
      end

      it 'can move to e3 if there is an enemy' do
        expect(pawn.can_move_to?(cell_e3, cells)).to be(true)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(pawn.move_to(cell_d3, cells)).to be(cell_d3)
      end

      it 'returns nil if the move is not possible' do
        expect(pawn.move_to(cell_d5, cells)).to be_nil
      end
    end
  end
end
