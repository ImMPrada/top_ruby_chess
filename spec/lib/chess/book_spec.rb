require 'spec_helper'

RSpec.describe Chess::Book do
  subject(:book) { described_class.new(board) }

  let(:board) { Chess::Board.new }

  describe '#commit_movement_intention' do
    describe 'when the piece choosed to move, is by the enemy team' do
      it 'returns an error of the submit' do
        expect(book.movement_intention('P', 'e7', 'e5', Chess::WHITE_TEAM)).to be(Chess::ERR_CELL_OCCUPED_BY_ENEMY)
      end
    end

    describe 'when the origin cell is empty' do
      it 'returns an error of the submit' do
        expect(book.movement_intention('P', 'e3', 'e4', Chess::WHITE_TEAM)).to be(Chess::ERR_EMPTY_ORIGIN_CELL)
      end
    end

    describe 'when the origin cell is occuped by another cell' do
      it 'returns an error of the submit' do
        expect(book.movement_intention('N', 'e2', 'f4', Chess::WHITE_TEAM)).to be(Chess::ERR_WRONG_PIECE_AT_CELL)
      end
    end

    describe "when selected piece can't be moved to target cell" do
      it 'returns an error of the commit' do
        expect(book.movement_intention('P', 'e2', 'f3', Chess::WHITE_TEAM)).to be(Chess::ERR_CANT_REACH_TARGET_CELL)
      end
    end

    describe 'when the move can be commited' do
      it 'returns succes' do
        expect(book.movement_intention('P', 'e2', 'e3', Chess::WHITE_TEAM)).to be(Chess::COMMIT_SUCCESS)
      end
    end

    describe 'when move a piece, expose the king to death' do
      before do
        puts board
        book.movement_intention('P', 'a2', 'a4', Chess::WHITE_TEAM)
        book.movement_intention('P', 'e7', 'e6', Chess::BLACK_TEAM)
        book.movement_intention('N', 'g1', 'h3', Chess::WHITE_TEAM)
        book.movement_intention('Q', 'd8', 'h4', Chess::BLACK_TEAM)
        puts board
      end

      it 'rollbacks the commitment' do
        expect(book.movement_intention('P', 'f2', 'f4', Chess::WHITE_TEAM)).to be(Chess::ROLLBACK_SUCCES)
      end
    end
  end

  describe '#castle_intention_on' do
    describe 'when castling can be done' do
      before do
        puts board
        book.movement_intention('N', 'g1', 'h3', Chess::WHITE_TEAM)
        book.movement_intention('P', 'e2', 'e3', Chess::WHITE_TEAM)
        book.movement_intention('B', 'f1', 'e2', Chess::WHITE_TEAM)
        puts board
      end

      it 'returns success commit' do
        expect(book.castle_intention_on(Chess::KING_SIDE, Chess::WHITE_TEAM)).to be(Chess::COMMIT_SUCCESS)
      end
    end

    describe "when castling can't be done because path is not empty" do
      before do
        puts board
        book.movement_intention('N', 'g1', 'h3', Chess::WHITE_TEAM)
        book.movement_intention('P', 'e2', 'e3', Chess::WHITE_TEAM)
        puts board
      end

      it 'returns error commit' do
        expect(book.castle_intention_on(Chess::KING_SIDE, Chess::WHITE_TEAM)).to be(Chess::CANT_CASTLING)
      end
    end

    describe "when castling can't be done because is not rook's first move" do
      before do
        puts board
        book.movement_intention('N', 'g1', 'h3', Chess::WHITE_TEAM)
        book.movement_intention('P', 'e2', 'e3', Chess::WHITE_TEAM)
        book.movement_intention('B', 'f1', 'e2', Chess::WHITE_TEAM)
        book.movement_intention('R', 'h1', 'g1', Chess::WHITE_TEAM)
        book.movement_intention('R', 'g1', 'h1', Chess::WHITE_TEAM)
        puts board
      end

      it 'returns error commit' do
        expect(book.castle_intention_on(Chess::KING_SIDE, Chess::WHITE_TEAM)).to be(Chess::CANT_CASTLING)
      end
    end

    describe "when castling can't be done because king will be death" do
      before do
        puts board
        book.movement_intention('N', 'b1', 'a3', Chess::WHITE_TEAM)
        book.movement_intention('P', 'd2', 'd3', Chess::WHITE_TEAM)
        book.movement_intention('B', 'c1', 'e3', Chess::WHITE_TEAM)
        book.movement_intention('Q', 'd1', 'd2', Chess::WHITE_TEAM)
        book.movement_intention('P', 'b2', 'b3', Chess::WHITE_TEAM)
        book.movement_intention('P', 'e7', 'e6', Chess::BLACK_TEAM)
        book.movement_intention('B', 'f8', 'a3', Chess::BLACK_TEAM)
        puts board
      end

      it 'returns succes rollback' do
        expect(book.castle_intention_on(Chess::QUEEN_SIDE, Chess::WHITE_TEAM)).to be(Chess::ROLLBACK_SUCCES)
      end

      it "keeps rook's can castling" do
        book.castle_intention_on(Chess::QUEEN_SIDE, Chess::WHITE_TEAM)
        rook = board.pieces[Chess::WHITE_TEAM].rooks.first
        rook = board.pieces[Chess::WHITE_TEAM].rooks.last unless rook.side == Chess::QUEEN_SIDE

        expect(rook.can_castling?).to be(true)
      end

      it "keeps king's can castling" do
        book.castle_intention_on(Chess::QUEEN_SIDE, Chess::WHITE_TEAM)
        king = board.pieces[Chess::WHITE_TEAM].king

        expect(king.can_castling?).to be(true)
      end
    end
  end
end
