require 'spec_helper'
require 'chess/core/board'
require 'chess/core/move/main'

require_relative '../../../../helper/move_main_pieces'

Intention = Struct.new(:type, :origin_cell, :target_cell)

RSpec.describe Chess::Core::Move::Main do
  subject(:move) { described_class.new(intention, board, Chess::WHITE_TEAM) }

  let(:board) { Chess::Core::Board.new }

  before { board.generate_cells }

  describe '#run' do
    describe 'when intention is type :move' do
      describe 'when intention commit is succesfull' do
        let(:intention) { Intention.new(:move, board.cells[1][4], board.cells[3][4]) }

        before { hardcode_pieces_case1(board) }

        it 'return succesful response' do
          expect(move.run).to be(Chess::COMMIT_SUCCESS)
        end

        it 'releases origin cell' do
          move.run
          expect(board.cells[1][4].occupant).to be_nil
        end

        it 'occupies target cell' do
          piece_moved = board.cells[1][4].occupant
          move.run
          expect(board.cells[3][4].occupant).to be(piece_moved)
        end
      end

      describe 'when intention has errors' do
        before { hardcode_pieces_case1(board) }

        describe 'when intention origin cell is empty' do
          let(:intention) { Intention.new(:move, board.cells[1][0], board.cells[3][0]) }

          it 'return error response' do
            expect(move.run).to be(Chess::ERR_EMPTY_ORIGIN_CELL)
          end
        end

        describe 'when intention origin cell is occuped by enemy' do
          let(:intention) { Intention.new(:move, board.cells[7][4], board.cells[3][4]) }

          it 'return error response' do
            expect(move.run).to be(Chess::ERR_CELL_OCCUPED_BY_ENEMY)
          end
        end
      end
    end
  end
end
