require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Pawn < BasePiece
        SYMBOL = :P

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        def can_move_to?(target_cell, cells)
          return false if target_cell.team == @team

          evaluate_with_one_move(
            target_cell,
            cells,
            attacking?(target_cell) ? attack_deltas : move_deltas
          )
        end

        private

        def move_deltas
          case @team
          when WHITE_TEAM
            return [[1, 0], [2, 0]] if first_move?

            [[1, 0]]
          when BLACK_TEAM
            return [[-1, 0], [-2, 0]] if first_move?

            [[-1, 0]]
          end
        end

        def attack_deltas
          case @team
          when WHITE_TEAM
            [[1, 1], [1, -1]]
          when BLACK_TEAM
            [[-1, 1], [-1, -1]]
          end
        end

        def can_move_only_once_at_time?
          true
        end

        def first_move?
          @cells_history.empty?
        end

        def attacking?(target_cell)
          target_cell.team == enemies_team
        end
      end
    end
  end
end
