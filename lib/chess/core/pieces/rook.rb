require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Rook < BasePiece
        SYMBOL = :R

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        def can_castle?(cells)
          return false unless first_move?

          target_cell = castling_target_cell(cells)
          return false unless target_cell

          can_move_to?(target_cell, cells)
        end

        def castle(cells)
          target_cell = castling_target_cell(cells)

          update_current_cell_to(target_cell)
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

        def castling_target_cell(cells)
          cells.dig(
            @current_cell.cartesian.row,
            queen_side? ? 3 : 5
          )
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
