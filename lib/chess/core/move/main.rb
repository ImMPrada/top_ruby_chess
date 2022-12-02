require_relative '../chess'
require_relative 'submit_services'
require_relative 'commit_services'
require_relative 'rollback_services'

module Chess
  module Core
    module Move
      class Main
        include SubmitServices
        include CommitServices
        include RollbackServices

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_filter)
          @intention = intention
          @cells = board.cells
          @pieces = board.pieces
          @symbol_filter = @intention[:symbol_filter].to_sym

          @team_filter = team_filter
          @piece_moved = nil
          @piece_captured = nil
        end

        def update_occuped_cells(occuped_cells_coordinates_by_teams)
          @occuped_cells_coordinates_by_teams = occuped_cells_coordinates_by_teams
        end

        private

        def set_origin_target_and_teams
          @origin_cell = assign_cell(:origin_cell)
          @target_cell = assign_cell(:target_cell)
          @friends_team = @team_filter
          @enemies_team = ([WHITE_TEAM, BLACK_TEAM] - [@friends_team]).first
        end

        def assign_cell(cell_type)
          splitted_cell_string = @intention[cell_type].split('')
          @cells[splitted_cell_string[0].to_sym][splitted_cell_string[1].to_i - 1]
        end

        def find_cell(algebraic)
          @cells[algebraic.column.to_sym][algebraic.row - 1]
        end
      end
    end
  end
end
