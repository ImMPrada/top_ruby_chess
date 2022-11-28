require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Bishop < BasePiece
        SYMBOL = :B
        TEXT = "\u265d".freeze

        def initialize(team, cell, cells)
          super(SYMBOL, team, cell, cells)
          @generated_deltas = []

          generate_deltas
        end

        private

        def text
          TEXT
        end

        def generate_deltas
          @generated_deltas[0] << [1, 1]
          @generated_deltas[1] << [1, -1]
          @generated_deltas[2] << [-1, -1]
          @generated_deltas[3] << [-1, 1]
        end
      end
    end
  end
end
