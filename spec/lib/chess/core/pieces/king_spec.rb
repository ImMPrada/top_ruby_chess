require 'spec_helper'
require 'chess/core/pieces/king'
require 'chess/core/pieces/rook'
require 'chess/core/cell'
require 'chess/core/board'

RSpec.describe Chess::Core::Pieces::King do
  subject(:king) { described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_e1) }

  let(:board) { Chess::Core::Board.new }
  let(:cells) do
    board.generate_cells
    board.cells
  end
  let(:cell_e1) { cells[0][4] }

  describe '.create_and_occupy' do
    it 'occupies the cell' do
      expect(king.current_cell.occupant).to be(king)
    end
  end

  describe '#neighbors' do
    it 'returns an array' do
      expect(king.neighbors(cells)).to be_an(Array)
    end

    it 'returns an array of cells' do
      expect(king.neighbors(cells).all? { |neighbor| neighbor.instance_of?(Chess::Core::Cell) }).to be(true)
    end
  end

  describe '#can_move_to?' do
    let(:cell_d1) { cells[0][3] }
    let(:cell_d2) { cells[1][3] }
    let(:cell_e2) { cells[1][4] }
    let(:cell_f2) { cells[1][5] }
    let(:cell_f1) { cells[0][5] }
    let(:cell_c1) { cells[0][2] }
    let(:cell_e3) { cells[2][4] }
    let(:cell_e8) { cells[7][4] }
    let(:cell_h1) { cells[0][7] }

    it 'can move to d1' do
      expect(king.can_move_to?(cell_d1, cells)).to be(true)
    end

    it 'can move to d2' do
      expect(king.can_move_to?(cell_d2, cells)).to be(true)
    end

    it 'can move to e2' do
      expect(king.can_move_to?(cell_e2, cells)).to be(true)
    end

    it 'can move to f2' do
      expect(king.can_move_to?(cell_f2, cells)).to be(true)
    end

    it 'can move to f1' do
      expect(king.can_move_to?(cell_f1, cells)).to be(true)
    end

    it "can't move to c1" do
      expect(king.can_move_to?(cell_c1, cells)).to be(false)
    end

    it "can't move to e3" do
      expect(king.can_move_to?(cell_e3, cells)).to be(false)
    end

    it "can't move to e8" do
      expect(king.can_move_to?(cell_e8, cells)).to be(false)
    end

    it "can't move to h1" do
      expect(king.can_move_to?(cell_h1, cells)).to be(false)
    end
  end

  describe '#move_to' do
    let(:cell_d1) { cells[0][3] }
    let(:cell_h1) { cells[0][7] }

    it 'returns target cell' do
      expect(king.move_to(cell_d1, cells)).to be(cell_d1)
    end

    it 'returns nil if the move is not possible' do
      expect(king.move_to(cell_h1, cells)).to be_nil
    end
  end

  describe '#castle_with' do
    describe 'queenside' do
      let(:rook) { Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_a1) }
      let(:cell_a1) { cells[0][0] }
      let(:cell_c1) { cells[0][2] }
      let(:cell_f1) { cells[0][5] }
      let(:cell_d1) { cells[0][3] }

      it 'returns nil if rook was moved' do
        rook.move_to(cell_c1, cells)
        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'returns nil if king was moved' do
        king.move_to(cell_f1, cells)
        king.move_to(cell_e1, cells)
        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'returns nil if there is a piece between king and rook' do
        Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_c1)

        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'occups the right cell with the rook' do
        king.castle_with(rook, cells)
        expect(cell_d1.occupant).to be(rook)
      end

      it 'occups the right cell with the king' do
        king.castle_with(rook, cells)
        expect(cell_c1.occupant).to be(king)
      end
    end

    describe 'kingside' do
      let(:rook) { Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_h1) }
      let(:cell_f1) { cells[0][5] }
      let(:cell_h1) { cells[0][7] }
      let(:cell_g1) { cells[0][6] }

      it 'returns nil if rook was moved' do
        rook.move_to(cell_f1, cells)
        rook.move_to(cell_h1, cells)
        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'returns nil if king was moved' do
        king.move_to(cell_f1, cells)
        king.move_to(cell_e1, cells)
        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'returns nil if there is a piece between king and rook' do
        Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_g1)

        expect(king.castle_with(rook, cells)).to be_nil
      end

      it 'occups the right cell with the rook' do
        king.castle_with(rook, cells)
        expect(cell_f1.occupant).to be(rook)
      end

      it 'occups the right cell with the king' do
        king.castle_with(rook, cells)
        expect(cell_g1.occupant).to be(king)
      end
    end
  end
end
