require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class King < Piece
    SYMBOL = :K

    Vector = Struct.new(:enable, :deltas)

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
      @capture_movements = nil

      generate_deltas
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      @generated_deltas[:v1].deltas << [0, 1]
      @generated_deltas[:v2].deltas << [1, 1]
      @generated_deltas[:v3].deltas << [1, 0]
      @generated_deltas[:v4].deltas << [1, -1]
      @generated_deltas[:v5].deltas << [0, -1]
      @generated_deltas[:v6].deltas << [-1, -1]
      @generated_deltas[:v7].deltas << [-1, 0]
      @generated_deltas[:v8].deltas << [-1, 1]

      @capture_movements = @generated_deltas
    end
    # rubocop:enable Metrics/AbcSize
  end
end
