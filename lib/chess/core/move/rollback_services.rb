require_relative '../constants'

module Chess
  module Core
    module Move
      module RollbackServices
        include Chess::Core::Constants

        def roll_back(target_cell, piece_captured = nil)
          piece_moved = target_cell.occupant
          piece_moved.roll_back_cell
          piece_captured&.back_to_board

          ROLLBACK_SUCCES
        end

        def roll_back_castling(king, rook)
          king.roll_back_cell
          rook.roll_back_cell

          ROLLBACK_SUCCES
        end
      end
    end
  end
end
