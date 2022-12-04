require_relative '../chess'

module Chess
  module Core
    module Move
      module SubmitServices
        def castle_submit(rook)
          errors = check_for_submiting_errors
          return errors if errors

          position_reached = @piece_at_origin_cell.castle_with(rook, @occuped_cells_coordinates_by_teams, rook.side)
          return ERR_ERR_CANT_CASTLING unless position_reached

          @piece_moved = [@piece_at_origin_cell, rook]
          SUBMIT_SUCCESS
        end
      end
    end
  end
end
