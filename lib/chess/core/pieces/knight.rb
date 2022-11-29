require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Knight < BasePiece
        SYMBOL = :N
        TEXT = "\u265d".freeze

        def self.create_and_occupy(team, current_cell)
          super(SYMBOL, team, current_cell)
        end

        private

        def move_deltas
          [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
        end

        def can_move_only_once_at_time?
          true
        end
      end
    end
  end
end
