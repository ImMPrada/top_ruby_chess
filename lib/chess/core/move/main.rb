require_relative '../constants'
require_relative 'commit_services'
require_relative 'rollback_services'
require_relative '../../functional/cell_notation'
require 'byebug'

module Chess
  module Core
    module Move
      class Main
        include Chess::Core::Move::CommitServices
        include Chess::Core::Move::RollbackServices
        include Chess::Functional::CellNotation
        include Chess::Constants

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_playing)
          @intention = intention
          @team_playing = team_playing
          @board = board
          @cells = @board.cells
          @pieces = @board.pieces
        end

        def run
          case @intention.type
          when INTENTION_IS_MOVE
            run_move
          when INTENTION_IS_KING_CASTLING
            run_castling(KING_SIDE)
          when INTENTION_IS_QUEEN_CASTLING
            run_castling(QUEEN_SIDE)
          end
        end

        private

        def run_move
          piece_captured = @intention.target_cell.occupant
          commitment = commit(
            @intention.origin_cell,
            @intention.target_cell,
            @cells,
            @team_playing
          )
          return commitment unless commitment == COMMIT_SUCCESS

          piece_captured&.takken
          return roll_back(@intention.target_cell, piece_captured) if king_under_risk?

          commitment
        end

        def king_under_risk?
          king_cell = @pieces[@team_playing].king.current_cell
          @board.can_any_piece_move_to?(
            king_cell,
            @cells,
            @pieces[@pieces[@team_playing].king.enemies_team].all
          )
        end

        def run_castling(side)
          rook = @pieces[@team_playing].queen_side_rook if side == QUEEN_SIDE
          rook = @pieces[@team_playing].king_side_rook if side == KING_SIDE

          commitment = commit_castling(
            @pieces[@team_playing].king,
            rook,
            @cells
          )
          return commitment unless commitment == COMMIT_SUCCESS
          return roll_back_castling(@pieces[@team_playing].king, rook) if king_under_risk?

          commitment
        end
      end
    end
  end
end
