require_relative '../chess'
# require_relative 'submit_services'
# require_relative 'commit_services'
# require_relative 'rollback_services'
require_relative '../../functional/cell_notation'
require 'byebug'

module Chess
  module Core
    module Move
      class Main
        include SubmitServices
        include CommitServices
        include RollbackServices
        include Chess::Functional::CellNotation

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_playing)
          @intention = intention
          @team_playing = team_playing
          @board = board
          @cells = board.cells
          @pieces = board.pieces
        end

        def run
          case @intention.type
          when :move
            run_move
          end
        end

        private

        def run_move
          piece_captured = @intention.target_cell.occupant
          commitment = commit(
            @intention.origin_cell,
            team_playing
          )
          return commitment unless commitment == COMMIT_SUCCESS

          piece_captured&.takken
          return roll_back(@intention.target_cell, piece_captured) if king_under_risk?

          commitment
        end

        def king_under_risk?
          king_cell = @board.pieces[@intention.target_cell.occupant.team].king.current_cell
          @board.can_any_piece_move_to?(
            king_cell,
            @cells,
            @pieces[@intention.target_cell.occupant.enemies_team]
          )
        end
      end
    end
  end
end
