require 'spec_helper'

RSpec.describe Chess::Board do
  subject(:board) { described_class.new }

  describe '#occuped_cells_coordinates_by_teams' do
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

  describe '#commit_movement_intention' do
    describe 'when move a piece, expose the king to death' do
      before do
        puts board
        board.commit_movement_intention('P', 'a2', 'a4', Chess::WHITE_TEAM)
        puts board
        board.commit_movement_intention('P', 'e7', 'e6', Chess::BLACK_TEAM)
        puts board
        board.commit_movement_intention('N', 'g1', 'h3', Chess::WHITE_TEAM)
        puts board
        board.commit_movement_intention('Q', 'd8', 'h4', Chess::BLACK_TEAM)
        puts board
      end

      it 'rollbacks the commitment' do
        expect(board.commit_movement_intention('P', 'f2', 'f4', Chess::WHITE_TEAM)).to be(Chess::ROLLBACK_SUCCES)
      end
    end
  end
end
