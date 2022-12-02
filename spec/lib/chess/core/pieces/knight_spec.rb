require 'spec_helper'
require 'chess/core/pieces/knight'
require 'chess/core/cell'
require 'chess/core/board'

RSpec.describe Chess::Core::Pieces::Knight do
  subject(:knight) { described_class.create_and_occupy(Chess::WHITE_TEAM, cell_e5) }

  let(:board) { Chess::Core::Board.new }
  let(:cells) do
    board.generate_cells
    board.cells
  end
  let(:cell_e5) { cells[4][4] }

  describe '.create_and_occupy' do
    it 'occupies the cell' do
      expect(knight.current_cell.occupant).to be(knight)
    end
  end

  describe 'whit other pieces occupyng cells, and starting at e5' do
    let(:cell_f7) { cells[6][5] }
    let(:cell_f3) { cells[2][5] }
    let(:cell_d3) { cells[2][3] }
    let(:cell_c4) { cells[3][2] }
    let(:cell_c7) { cells[6][2] }
    let(:cell_d7) { cells[6][3] }
    let(:cell_g4) { cells[3][6] }
    let(:cell_c3) { cells[2][2] }

    before do
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_f3)
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_c4)
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_c7)
      described_class.create_and_occupy(Chess::WHITE_TEAM, cell_d7)
      described_class.create_and_occupy(Chess::WHITE_TEAM, cell_g4)
    end

    describe '#can_move_to?' do
      it 'can move to f7' do
        expect(knight.can_move_to?(cell_f7, cells)).to be(true)
      end

      it 'can move to f3' do
        expect(knight.can_move_to?(cell_f3, cells)).to be(true)
      end

      it 'can move to d3' do
        expect(knight.can_move_to?(cell_d3, cells)).to be(true)
      end

      it 'can move to c4' do
        expect(knight.can_move_to?(cell_c4, cells)).to be(true)
      end

      it "can't move to c7" do
        expect(knight.can_move_to?(cell_c7, cells)).to be(false)
      end

      it "can't move to d7" do
        expect(knight.can_move_to?(cell_d7, cells)).to be(false)
      end

      it "can't move to g4" do
        expect(knight.can_move_to?(cell_g4, cells)).to be(false)
      end

      it "can't move to c3" do
        expect(knight.can_move_to?(cell_c3, cells)).to be(false)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(knight.move_to(cell_f3, cells)).to be(cell_f3)
      end

      it 'returns nil if the move is not possible' do
        expect(knight.move_to(cell_c3, cells)).to be_nil
      end
    end
  end
end
