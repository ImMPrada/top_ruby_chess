require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Bishop < BasePiece
        SYMBOL = :B
        TEXT = "\u265d".freeze

        def initialize(team, cell)
          super(SYMBOL, team, cell)
          @generated_deltas = []

          generate_deltas
        end

        private

        def text
          TEXT
        end

        def generate_deltas
          @generated_deltas << [1, 1]
          @generated_deltas << [-1, 1]
          @generated_deltas << [-1, -1]
          @generated_deltas << [1, -1]
        end
      end
    end
  end
end
