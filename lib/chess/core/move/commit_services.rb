require_relative '../chess'

module Chess
  module Core
    module Move
      module CommitServices
        def castle_commit
          update_cells_occupation
          @king_position_string = @piece_moved.first.position.algebraic.to_s

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

        def update_cells_occupation
          @piece_moved.each do |piece|
            find_cell(piece.current_step.prev_step.position.algebraic).free
            find_cell(piece.position.algebraic).free
            find_cell(piece.position.algebraic).occup_by(piece)
          end
        end

        def remove_captured_from_pieces
          case @piece_captured.symbol
          when :Q
            @pieces[@enemies_team].queens.delete(@piece_captured)
          when :B
            @pieces[@enemies_team].bishops.delete(@piece_captured)
          when :P
            @pieces[@enemies_team].pawns.delete(@piece_captured)
          when :N
            @pieces[@enemies_team].knights.delete(@piece_captured)
          when :R
            @pieces[@enemies_team].rooks.delete(@piece_captured)
          end
        end
      end
    end
  end
end
