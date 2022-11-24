require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Knight < Piece
    SYMBOL = :N

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = {
        v1: Vector.new(true, []),
        v2: Vector.new(true, []),
        v3: Vector.new(true, []),
        v4: Vector.new(true, []),
        v5: Vector.new(true, []),
        v6: Vector.new(true, []),
        v7: Vector.new(true, []),
        v8: Vector.new(true, [])
      }
      @capture_moves = nil

      generate_deltas
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      super(position_algebraic, capturing ? @capture_moves : @generated_deltas, occuped_cells)
    end

    def can_attack_to?(target_position_algebraic, occuped_cells)
      can_move_to?(target_position_algebraic, @capture_moves, occuped_cells)
    end

    def to_s
      super("\u265e")
    end

    private

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      @generated_deltas[:v1].deltas << [-1, 2]
      @generated_deltas[:v2].deltas << [1, 2]
      @generated_deltas[:v3].deltas << [2, 1]
      @generated_deltas[:v4].deltas << [2, -1]
      @generated_deltas[:v5].deltas << [1, -2]
      @generated_deltas[:v6].deltas << [-1, -2]
      @generated_deltas[:v7].deltas << [-2, -1]
      @generated_deltas[:v8].deltas << [-2, 1]

      @capture_moves = @generated_deltas
    end
    # rubocop:enable Metrics/AbcSize
  end
end
