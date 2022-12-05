require 'spec_helper'
require 'chess/core/board'
require 'chess/core/cell'
require_relative '../../../helpers/board_pieces'

RSpec.describe Chess::Core::Board do
  include Helpers::BoardPieces

  describe '. create_and_occupy' do
    subject(:board) { described_class.create_and_occupy }

    it 'creates an array at @cells' do
      expect(board.cells).to be_a(Array)
    end

    it 'all items in @cells are cells' do
      cells = board.cells
      check = cells.all? do |cells_row|
        cells_row.all? { |cell| cell.instance_of?(Chess::Core::Cell) }
      end

      expect(check).to be(true)
    end

    it 'creates a king for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].king.instance_of?(Chess::Core::Pieces::King)).to be(true)
    end

    it 'creates a king for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].king.instance_of?(Chess::Core::Pieces::King)).to be(true)
    end

    it 'creates a queen for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].queens.first.instance_of?(Chess::Core::Pieces::Queen)).to be(true)
    end

    it 'creates a queen for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].queens.first.instance_of?(Chess::Core::Pieces::Queen)).to be(true)
    end

    it 'creates 2 bishops for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].bishops.size).to be(2)
    end

    it 'creates 2 bishops for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].bishops.size).to be(2)
    end

    it 'creates 2 knights for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].knights.size).to be(2)
    end

    it 'creates 2 knights for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].knights.size).to be(2)
    end

    it 'creates 2 rooks for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].rooks.size).to be(2)
    end

    it 'creates 2 rooks for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].rooks.size).to be(2)
    end

    it 'creates 8 pawns for white team' do
      expect(board.pieces[Chess::Constants::WHITE_TEAM].pawns.size).to be(8)
    end

    it 'creates 8 pawns for black team' do
      expect(board.pieces[Chess::Constants::BLACK_TEAM].pawns.size).to be(8)
    end
  end

  describe '#can_any_piece_move_to?' do
    subject(:board) { described_class.new }

    let(:cells) { board.cells }

    before { board.generate_cells }

    describe 'when cells are all released' do
      it 'returns nil' do
        expect(board.can_any_piece_move_to?(
                 cells.sample.sample,
                 cells,
                 board.pieces[Chess::Constants::WHITE_TEAM].all
               )).to be_nil
      end
    end

    describe 'with a bishop at a1' do
      let(:bishop) { Chess::Core::Pieces::Bishop.create_and_occupy(Chess::Constants::WHITE_TEAM, cells[0][0]) }

      it 'returns true when a cell is at c3' do
        expect(board.can_any_piece_move_to?(
                 cells[2][2],
                 cells,
                 [bishop]
               )).to be(true)
      end

      it 'returns false when a cell is at c4' do
        expect(board.can_any_piece_move_to?(
                 cells[3][2],
                 cells,
                 [bishop]
               )).to be(false)
      end

      describe 'with also a rook at h4' do
        let(:rook) { Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::WHITE_TEAM, cells[3][7]) }

        it 'returns false when a cell is at c4' do
          expect(board.can_any_piece_move_to?(
                   cells[3][2],
                   cells,
                   [bishop, rook]
                 )).to be(true)
        end
      end
    end
  end

  describe '#checkmate?' do
    subject(:board) { described_class.new }

    let(:check_piece) { board.pieces[Chess::Constants::BLACK_TEAM].rooks.first }
    let(:king_in_check) { board.pieces[Chess::Constants::WHITE_TEAM].king }

    before { board.generate_cells }

    describe 'when there is a checkmate' do
      before { hardcode_pieces_checkmate_case1(board) }

      it 'returns true' do
        expect(board.checkmate?(check_piece, king_in_check, board.pieces, board.cells)).to be(true)
      end
    end

    describe 'when the king can escape' do
      before { hardcode_pieces_checkmate_case2(board) }

      it 'returns false' do
        expect(board.checkmate?(check_piece, king_in_check, board.pieces, board.cells)).to be(false)
      end
    end

    describe 'when a friend piece, can attack the enemy piece' do
      before { hardcode_pieces_checkmate_case3(board) }

      it 'returns false' do
        expect(board.checkmate?(check_piece, king_in_check, board.pieces, board.cells)).to be(false)
      end
    end

    describe 'when a friend piece, can intersect the enemy path' do
      before { hardcode_pieces_checkmate_case4(board) }

      it 'returns false' do
        expect(board.checkmate?(check_piece, king_in_check, board.pieces, board.cells)).to be(false)
      end
    end
  end
end
