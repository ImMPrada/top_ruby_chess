require_relative '../constants'

module Chess
  module Core
    module Move
      module CommitServices

        include Chess::Core::Constants

        def commit_castling(king, rook, cells)
          response = king.castle_with(rook, cells)
          return ERR_CANT_CASTLING unless response

          COMMIT_SUCCESS
        end

        def commit(origin_cell, target_cell, cells, team_playing)
          errors = check_for_commiting_errors(origin_cell, team_playing)
          return errors if errors

          piece_at_origin_cell = origin_cell.occupant
          position_reached = piece_at_origin_cell.move_to(
            target_cell,
            cells
          )
          return ERR_CANT_REACH_TARGET_CELL unless position_reached

          COMMIT_SUCCESS
        end

        private

        def check_for_commiting_errors(origin_cell, team_playing)
          return ERR_EMPTY_ORIGIN_CELL unless origin_cell.occupied?
          return ERR_CELL_OCCUPED_BY_ENEMY unless origin_cell.team == team_playing

          false
        end
      end
    end
  end
end
