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

        def commit
          @piece_captured = @target_cell.occupant
          remove_captured_from_pieces if @piece_captured

          update_cells_occupation
          @king_position_string = @pieces[@friends_team].king.position.algebraic.to_s

          COMMIT_SUCCESS
        end

        private

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
