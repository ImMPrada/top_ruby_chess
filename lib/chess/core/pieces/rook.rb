require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Rook < BasePiece
        SYMBOL = :R
        TEXT = "\u265f".freeze

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        def can_castle?(cells)
          return false unless first_move?

          target_cell = cells.dig(
            @current_cell.cartesian.row,
            @current_cell.cartesian.column + (queen_side? ? 3 : -2)
          )
          return false unless target_cell

          can_move_to?(target_cell, cells)
        end

        def queen_side?
          side == QUEEN_SIDE
        end

        def king_side?
          side == KING_SIDE
        end

        private

        def side
          return QUEEN_SIDE if @current_cell.algebraic.column == 'a'
          return KING_SIDE if @current_cell.algebraic.column == 'h'

          nil
        end

        def move_deltas
          [[1, 0], [0, 1], [-1, 0], [0, -1]]
        end

        def can_move_only_once_at_time?
          false
        end

        def first_move?
          @cells_history.empty?
        end
      end
    end
  end
end
