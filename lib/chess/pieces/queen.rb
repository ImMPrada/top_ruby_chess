require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Queen < Piece
    SYMBOL = :Q

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
      super("\u265b")
    end

    private

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      (MIN_INDEX..MAX_INDEX).each do |i|
        next if i == MIN_INDEX

        @generated_deltas[:v1].deltas << [0, i]
        @generated_deltas[:v2].deltas << [i, i]
        @generated_deltas[:v3].deltas << [i, 0]
        @generated_deltas[:v4].deltas << [i, -i]
        @generated_deltas[:v5].deltas << [0, -i]
        @generated_deltas[:v6].deltas << [-i, -i]
        @generated_deltas[:v7].deltas << [-i, 0]
        @generated_deltas[:v8].deltas << [-i, i]
      end

      @capture_moves = @generated_deltas
    end
    # rubocop:enable Metrics/AbcSize
  end
end
