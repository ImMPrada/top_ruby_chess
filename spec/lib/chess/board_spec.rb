require 'spec_helper'

RSpec.describe Chess::Board do
  subject(:board) { described_class.new }

  describe '#occuped_cells' do
    let(:array_of_columns) { Chess::COLUMNS.map(&:to_sym) }
    let(:array_of_rows) { (1..8).to_a }

    before do
      board
    end

    it 'returns a hash of to kewys: each team, in eache key, a has of two keys: algebraic and coordinates' do
      expect(board.occuped_cells_coordinates_by_teams[[Chess::WHITE_TEAM,
                                                       Chess::BLACK_TEAM].sample].class).to be(Array)
    end

    describe 'when board is created, occuped cells, are initial occuped cells' do
      let(:white_initial_occuped_cells) do
        [
          [0, 0],
          [1, 0],
          [2, 0],
          [3, 0],
          [4, 0],
          [5, 0],
          [6, 0],
          [7, 0],
          [0, 1],
          [1, 1],
          [2, 1],
          [3, 1],
          [4, 1],
          [5, 1],
          [6, 1],
          [7, 1]
        ]
      end
      let(:black_initial_occuped_cells) do
        [
          [0, 7],
          [1, 7],
          [2, 7],
          [3, 7],
          [4, 7],
          [5, 7],
          [6, 7],
          [7, 7],
          [0, 6],
          [1, 6],
          [2, 6],
          [3, 6],
          [4, 6],
          [5, 6],
          [6, 6],
          [7, 6]
        ]
      end

      it 'returns algebraic notation of occuped cells for white team' do
        expect(board.occuped_cells_coordinates_by_teams[Chess::WHITE_TEAM]).to match_array(white_initial_occuped_cells)
      end

      it 'returns algebraic notation of occuped cells for black team' do
        expect(board.occuped_cells_coordinates_by_teams[Chess::BLACK_TEAM]).to match_array(black_initial_occuped_cells)
      end
    end
  end

  describe '#submit_movement' do
    describe 'when origin cell of the movement is empty' do
      it 'returns an error symbol' do
        expect(board.submit_movement(:P, 'a5', 'a6')).to be(Chess::ERR_EMPTY_ORIGIN_CELL)
      end
    end

    describe 'when origin cell is occuped for a cell of other class' do
      it 'returns an error symbol' do
        expect(board.submit_movement(:B, 'a2', 'b3')).to be(Chess::ERR_WRONG_PIECE_AT_CELL)
      end
    end

    describe "when origin cell is occuped by the peace, but can't move to target_cell" do
      it 'returns an error symbol' do
        expect(board.submit_movement(:P, 'a2', 'a5')).to be(Chess::ERR_CAN_REACH_TARGET_CELL)
      end
    end

    describe 'when submiting is succesful' do
      it 'returns the piece moved' do
        expect(board.submit_movement(:P, 'a2', 'a4')).to be_a(Chess::Pawn)
      end

      it 'returns piece moved, whit position updated' do
        pawn_updated = board.submit_movement(:P, 'a2', 'a4')
        expect(pawn_updated.position.algebraic.to_s).to eq('a4')
      end
    end
  end

  describe '#commit_movement' do
    describe 'when movement is succesfuly commited' do
      let(:piece_moved) { board.submit_movement(:P, 'a2', 'a4') }

      it 'returns succes symbol' do
        expect(board.commit_movement(piece_moved)).to be(Chess::COMMIT_SUCCESS)
      end
    end

    describe "when the movement can't be performed, because the king could die" do
      before do
        puts board
        piece_moved = board.submit_movement(:P, 'a2', 'a3')
        board.commit_movement(piece_moved)
        puts board
        piece_moved = board.submit_movement(:P, 'e7', 'e6')
        board.commit_movement(piece_moved)
        puts board
        piece_moved = board.submit_movement(:P, 'h2', 'h4')
        board.commit_movement(piece_moved)
        puts board
        piece_moved = board.submit_movement(:B, 'f8', 'b4')
        board.commit_movement(piece_moved)
        puts board
      end

      it 'returns an error symbol' do
        piece_moved = board.submit_movement(:P, 'd2', 'd3')
        expect(board.commit_movement(piece_moved)).to be(Chess::ERR_KING_WILL_DIE)
      end
    end
  end
end
