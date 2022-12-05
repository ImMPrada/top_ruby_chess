require 'spec_helper'
require 'chess/core/board'
require 'chess/core/move/main'

require_relative '../../../../helpers/move_main_pieces'

Intention = Struct.new(:type, :origin_cell, :target_cell)

RSpec.describe Chess::Core::Move::Main do
  include Helpers::MoveMainPieces

  subject(:move) { described_class.new(intention, board, Chess::Constants::WHITE_TEAM) }

  let(:board) { Chess::Core::Board.new }

  before { board.generate_cells }

  describe '#run' do
    describe 'when intention is type :move' do
      describe 'when intention commit is succesfull' do
        describe 'when intention target cell is free' do
          let(:intention) { Intention.new(:move, board.cells[1][4], board.cells[3][4]) }

          before { hardcode_pieces_case1(board) }

          it 'return succesful response' do
            expect(move.run).to be(Chess::Constants::COMMIT_SUCCESS)
          end

          it 'releases origin cell' do
            move.run
            expect(board.cells[1][4].occupant).to be_nil
          end

          it 'occupies target cell' do
            moved_piece = board.cells[1][4].occupant
            move.run
            expect(board.cells[3][4].occupant).to be(moved_piece)
          end
        end

        describe 'when intention target cell is occupied by enemy' do
          let(:intention) { Intention.new(:move, board.cells[1][4], board.cells[7][4]) }

          before { hardcode_pieces_case2(board) }

          it 'return succesful response' do
            expect(move.run).to be(Chess::Constants::COMMIT_SUCCESS)
          end

          it 'releases origin cell' do
            move.run
            expect(board.cells[1][4].occupant).to be_nil
          end

          it 'occupies target cell' do
            moved_piece = board.cells[1][4].occupant
            move.run
            expect(board.cells[7][4].occupant).to be(moved_piece)
          end

          it 'updates enemy board pieces list' do
            piece_captured = board.cells[7][4].occupant
            move.run
            expect(board.pieces[Chess::Constants::BLACK_TEAM].captured).to eq([piece_captured])
          end
        end
      end

      describe 'when intention has errors' do
        before { hardcode_pieces_case1(board) }

        describe 'when intention origin cell is empty' do
          let(:intention) { Intention.new(:move, board.cells[1][0], board.cells[3][0]) }

          it 'return error response' do
            expect(move.run).to be(Chess::Constants::ERR_EMPTY_ORIGIN_CELL)
          end
        end

        describe 'when intention origin cell is occuped by enemy' do
          let(:intention) { Intention.new(:move, board.cells[7][4], board.cells[3][4]) }

          it 'return error response' do
            expect(move.run).to be(Chess::Constants::ERR_CELL_OCCUPED_BY_ENEMY)
          end
        end
      end

      describe 'when after move, friend king is in danger' do
        let(:intention) { Intention.new(:move, board.cells[2][4], board.cells[2][7]) }

        before { hardcode_pieces_case3(board) }

        it 'returns rollback response' do
          expect(move.run).to be(Chess::Constants::ROLLBACK_SUCCES)
        end

        it 'rolls back target cell occupancy' do
          captured_piece = board.cells[2][7].occupant
          move.run
          expect(board.cells[2][7].occupant).to be(captured_piece)
        end

        it 'rolls back origin cell occupancy' do
          moved_piece = board.cells[2][4].occupant
          move.run
          expect(board.cells[2][4].occupant).to be(moved_piece)
        end

        it 'rolls back board pieces list of captured' do
          initial_list_state = board.pieces[Chess::Constants::BLACK_TEAM].captured
          move.run
          expect(board.pieces[Chess::Constants::BLACK_TEAM].captured).to eq(initial_list_state)
        end
      end
    end

    describe 'when intention is type :castling_queen_side' do
      let(:intention) { Intention.new(:castling_queen_side, nil, nil) }

      before { hardcode_pieces_case4(board) }

      describe "when castling can't be done" do
        it 'returns an error resposne' do
          rook = board.pieces[Chess::Constants::WHITE_TEAM].queen_side_rook
          rook.move_to(board.cells.dig(0, 3), board.cells)
          expect(move.run).to be(Chess::Constants::ERR_CANT_CASTLING)
        end
      end

      describe 'when castling is succesfull' do
        it 'returns succesful response' do
          expect(move.run).to be(Chess::Constants::COMMIT_SUCCESS)
        end

        it 'releases initial cell of king' do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king.current_cell
          move.run
          expect(origin_cell.occupant).to be_nil
        end

        it 'releases initial cell of rook' do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].queen_side_rook.current_cell
          move.run
          expect(origin_cell.occupant).to be_nil
        end

        it 'occupies target castling cell by king' do
          move.run
          expect(board.cells[0][2].occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].king)
        end

        it 'occupies target castling cell by rook' do
          rook = board.pieces[Chess::Constants::WHITE_TEAM].queen_side_rook
          move.run
          expect(board.cells[0][3].occupant).to be(rook)
        end
      end
    end

    describe 'when intention is type :castling_king_side' do
      let(:intention) { Intention.new(:castling_king_side, nil, nil) }

      before { hardcode_pieces_case4(board) }

      describe "when castling can't be done" do
        it 'returns an error resposne' do
          rook = board.pieces[Chess::Constants::WHITE_TEAM].king_side_rook
          rook.move_to(board.cells.dig(0, 5), board.cells)
          expect(move.run).to be(Chess::Constants::ERR_CANT_CASTLING)
        end
      end

      describe 'when castling is succesfull' do
        it 'returns succesful response' do
          expect(move.run).to be(Chess::Constants::COMMIT_SUCCESS)
        end

        it 'releases initial cell of king' do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king.current_cell
          move.run
          expect(origin_cell.occupant).to be_nil
        end

        it 'releases initial cell of rook' do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king_side_rook.current_cell
          move.run
          expect(origin_cell.occupant).to be_nil
        end

        it 'occupies target castling cell by king' do
          move.run
          expect(board.cells[0][6].occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].king)
        end

        it 'occupies target castling cell by rook' do
          rook = board.pieces[Chess::Constants::WHITE_TEAM].king_side_rook
          move.run
          expect(board.cells[0][5].occupant).to be(rook)
        end
      end
    end

    describe 'when rollback is needed' do
      before { hardcode_pieces_case5(board) }

      describe 'when intention is type :castling_queen_side' do
        let(:intention) { Intention.new(:castling_queen_side, nil, nil) }

        it 'returns succesful response' do
          expect(move.run).to be(Chess::Constants::ROLLBACK_SUCCES)
        end

        it 'keeps free target cell of king castling' do
          move.run
          expect(board.cells[0][2].occupant).to be_nil
        end

        it 'keeps free target cell of rook castling' do
          move.run
          expect(board.cells[0][3].occupant).to be_nil
        end

        it "rolls back the king to it's origin target" do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king.current_cell
          move.run
          expect(origin_cell.occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].king)
        end

        it "rolls back the rook to it's origin target" do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].queen_side_rook.current_cell
          move.run
          expect(origin_cell.occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].queen_side_rook)
        end
      end

      describe 'when intention is type :castling_king_side' do
        let(:intention) { Intention.new(:castling_king_side, nil, nil) }

        it 'returns succesful response' do
          expect(move.run).to be(Chess::Constants::ROLLBACK_SUCCES)
        end

        it 'keeps free target cell of king castling' do
          move.run
          expect(board.cells[0][6].occupant).to be_nil
        end

        it 'keeps free target cell of rook castling' do
          move.run
          expect(board.cells[0][5].occupant).to be_nil
        end

        it "rolls back the king to it's origin target" do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king.current_cell
          move.run
          expect(origin_cell.occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].king)
        end

        it "rolls back the rook to it's origin target" do
          origin_cell = board.pieces[Chess::Constants::WHITE_TEAM].king_side_rook.current_cell
          move.run
          expect(origin_cell.occupant).to be(board.pieces[Chess::Constants::WHITE_TEAM].king_side_rook)
        end
      end
    end
  end
end
