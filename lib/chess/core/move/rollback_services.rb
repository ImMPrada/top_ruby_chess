require_relative '../chess'

module Chess
  module Core
    module Move
      module RollbackServices
        def roll_back(target_cell, piece_captured)
          piece_moved = target_cell.occupant
          piece_moved.roll_back_cell
          piece_captured&.back_to_board

          ROLLBACK_SUCCES
        end

        def roll_back_castling
          roll_back_piece_moved
          @king_position_string = @pieces[@friends_team].king.position.algebraic.to_s

          ROLLBACK_SUCCES
        end

        private

        def roll_back_piece_moved
          @piece_moved.each do |piece|
            find_cell(piece.current_step.prev_step.position.algebraic).occup_by(piece)
            find_cell(piece.position.algebraic).free
            piece.roll_back_step
          end
        end

        def add_captured_to_pieces
          case @piece_captured.symbol
          when :Q
            @pieces[@enemies_team].queens << @piece_captured
          when :B
            @pieces[@enemies_team].bishops << @piece_captured
          when :P
            @pieces[@enemies_team].pawns << @piece_captured
          when :N
            @pieces[@enemies_team].knights << @piece_captured
          when :R
            @pieces[@enemies_team].rooks << @piece_captured
          end
        end
      end
    end
  end
end
