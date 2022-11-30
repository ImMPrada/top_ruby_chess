require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Rook < BasePiece
        SYMBOL = :R
        TEXT = "\u265f".freeze

        attr_reader :side

        def self.create_and_occupy(team, current_cell)
          this_rook = super(SYMBOL, team, current_cell)
          this_rook.assign_side

          this_rook
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
          @side == QUEEN_SIDE
        end

        def king_side?
          @side == KING_SIDE
        end

        def assign_side
          return @side = QUEEN_SIDE if @current_cell.algebraic.column == 'a'
          return @side = KING_SIDE if @current_cell.algebraic.column == 'b'

          @side = nil
        end

        private

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
