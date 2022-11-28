require_relative 'base_piece'
require 'byebug'

module Chess
  module Pieces
    class Bishop < BasePiece
      SYMBOL = :B
      TEXT_SYMBOL = "\u265d".freeze

      def initialize(team, cell=nil, cells=nil)
        super(SYMBOL, team, cell, cells)
        @generated_deltas = []

        # generate_deltas
      end

      def can_attack_to?(target_position_algebraic, occuped_cells)
        can_move_to?(target_position_algebraic, @capture_moves, occuped_cells)
      end

      private

      def text_symbol
        TEXT_SYMBOL
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
