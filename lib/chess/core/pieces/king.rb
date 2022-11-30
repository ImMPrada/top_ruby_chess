require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class King < BasePiece
        SYMBOL = :K

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        def castle_with(piece, cells)
          return unless can_castle_with?(piece, cells)

          target_cell = cells.dig(@current_cell.row, @current_cell.column + (piece.queen_side? ? -2 : 2))
          update_current_cell_to(target_cell)
        end

        private

        def can_castle_with?(piece, cells)
          return false unless piece.instance_of?(Rook)
          return false unless first_move? && piece.can_castle?(cells)

          target_cell = cells.dig(@current_cell.row, @current_cell.column + (piece.queen_side? ? -2 : 2))
          return false if target_cell.team == @team

          evaluate_with_one_move(target_cell, cells, castling_deltas)
        end

        def castling_deltas
          [[0, 2], [0, -2]]
        end

        def move_deltas
          [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        end

        def can_move_only_once_at_time?
          true
        end

        def first_move?
          @cells_history.empty?
        end
      end
    end
  end
end
