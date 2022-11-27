require_relative '../chess'
require_relative 'base_piece'
require 'byebug'

module Chess
  module Pieces
    class Bishop < BasePiece
      SYMBOL = :B
      TEXT = "\u265d".freeze

      def initialize(coordinates, team)
        super(coordinates, SYMBOL, team)
        @generated_deltas = [
          v1: Vector.new(true, []),
          v2: Vector.new(true, []),
          v3: Vector.new(true, []),
          v4: Vector.new(true, [])
        ]

        generate_deltas
      end

      def move_to(position_algebraic, occuped_cells)
        super(position_algebraic, @generated_deltas, occuped_cells)
      end

      def can_attack_to?(target_position_algebraic, occuped_cells)
        can_move_to?(target_position_algebraic, @capture_moves, occuped_cells)
      end

      def to_s
        super(TEXT)
      end

      private

      # rubocop:disable Metrics/AbcSize
      def generate_deltas
        (MIN_INDEX..MAX_INDEX).each do |i|
          next if i == MIN_INDEX

          @generated_deltas[0].deltas << [i, i]
          @generated_deltas[1].deltas << [i, -i]
          @generated_deltas[2].deltas << [-i, -i]
          @generated_deltas[3].deltas << [-i, i]
        end

        @capture_moves = @generated_deltas
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
