require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Bishop < Piece
    SYMBOL = :B

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = {
        v1: Vector.new(true, []),
        v2: Vector.new(true, []),
        v3: Vector.new(true, []),
        v4: Vector.new(true, [])
      }
      @capture_movements = nil

      generate_deltas
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      (MIN_INDEX..MAX_INDEX).each do |i|
        next if i == MIN_INDEX

        @generated_deltas[:v1].deltas << [i, i]
        @generated_deltas[:v2].deltas << [i, -i]
        @generated_deltas[:v3].deltas << [-i, -i]
        @generated_deltas[:v4].deltas << [-i, i]
      end

      @capture_movements = @generated_deltas
    end
    # rubocop:enable Metrics/AbcSize
  end
end
