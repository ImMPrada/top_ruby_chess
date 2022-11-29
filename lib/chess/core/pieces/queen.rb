require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Queen < BasePiece
        SYMBOL = :Q

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        private

        def move_deltas
          [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
        end

        def can_move_only_once_at_time?
          false
        end
      end
    end
  end
end
