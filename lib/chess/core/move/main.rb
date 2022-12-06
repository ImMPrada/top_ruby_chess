require_relative '../chess'
require_relative 'commit_services'
require_relative 'rollback_services'
require_relative '../../functional/cell_notation'

module Chess
  module Core
    module Move
      class Main
        include Chess::Core::Move::CommitServices
        include Chess::Core::Move::RollbackServices
        include Chess::Functional::CellNotation

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_playing)
          @intention = intention
          @team_playing = team_playing
          @board = board
        end

        def run
          case @intention.type
          when MOVE_INTENTION
            run_move
          when KING_CASTLING_INTENTION
            run_castling(KING_SIDE)
          when QUEEN_CASTLING_INTENTION
            run_castling(QUEEN_SIDE)
          end
        end

        private

        def run_move
          piece_captured = @intention.target_cell.occupant
          commitment = commit(
            @intention.origin_cell,
            @intention.target_cell,
            @board.cells,
            @team_playing
          )
          return commitment unless commitment == COMMIT_SUCCESS

          piece_captured&.become_captured
          return roll_back(@intention.target_cell, piece_captured) if king_under_risk?

          commitment
        end

        def king_under_risk?
          king = @board.pieces[@team_playing].king
          king_cell = king.current_cell
          @board.can_any_piece_move_to?(
            king_cell,
            @board.cells,
            @board.pieces[king.enemies_team].all
          )
        end

        def run_castling(side)
          team_pieces = @board.pieces[@team_playing]
          rook = side == QUEEN_SIDE ? team_pieces.queen_side_rook : team_pieces.king_side_rook

          commitment = commit_castling(
            @board.pieces[@team_playing].king,
            rook,
            @board.cells
          )
          return commitment unless commitment == COMMIT_SUCCESS
          return roll_back_castling(@board.pieces[@team_playing].king, rook) if king_under_risk?

          commitment
        end
      end
    end
  end
end
