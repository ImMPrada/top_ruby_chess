require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Pawn < BasePiece
        SYMBOL = :P
        TEXT = "\u265f".freeze

        def self.create_and_occupy(team, current_cell)
          self_pawn = super(SYMBOL, team, current_cell)
          @first_move = true

          self_pawn
        end

        def can_move_to?(target_cell, cells)
          deltas = attacking?(target_cell) ? attack_deltas : move_deltas

          return false if target_cell.team == @team
          return evaluate_with_one_move(target_cell, cells, deltas) if can_move_only_once_at_time?

          evaluate_with_path(target_cell, cells, deltas)
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
