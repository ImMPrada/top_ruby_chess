require_relative '../chess'

module Chess
  module CommitServices
    def castle_commit
      @piece_moved.each do |piece|
        find_cell(piece.current_step.prev_step.position.algebraic).free
        find_cell(piece.position.algebraic).occup_by(piece)
      end

      @king_position_string = @piece_moved.first.position.algebraic.to_s
      COMMIT_SUCCESS
    end

    def commit
      @piece_captured = @target_cell.occupant
      remove_captured_from_pieces if @piece_captured

      @origin_cell.free
      @target_cell.free
      @target_cell.occup_by(@piece_moved)
      @king_position_string = @pieces[@friends_team].king.position.algebraic.to_s

      COMMIT_SUCCESS
    end
  end
end
