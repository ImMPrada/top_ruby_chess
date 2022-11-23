require_relative '../chess'

module Chess
  module RollbackServices
    def roll_back
      find_cell(@piece_moved.position.algebraic).free

      @piece_moved.roll_back_step
      find_cell(@piece_moved.position.algebraic).occup_by(@piece_moved)

      return ROLLBACK_SUCCES unless @piece_captured

      find_cell(@piece_captured.position.algebraic).occup_by(@piece_captured)
      add_captured_to_pieces
      @piece_captured = nil

      ROLLBACK_SUCCES
    end

    def roll_back_castling
      @piece_moved.each do |piece|
        find_cell(piece.current_step.prev_step.position.algebraic).occup_by(piece)
        find_cell(piece.position.algebraic).free
        piece.roll_back_step
      end

      @king_position_string = @piece_moved.first.position.algebraic.to_s

      ROLLBACK_SUCCES
    end
  end
end
