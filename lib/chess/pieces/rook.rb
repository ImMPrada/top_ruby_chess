require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Rook < Piece
    SYMBOL = :R

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = {
        v1: Vector.new(true, []),
        v2: Vector.new(true, []),
        v3: Vector.new(true, []),
        v4: Vector.new(true, [])
      }
      @capture_movements = nil
      @first_move = true

      generate_deltas
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      super_response = super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
      return unless super_response

      @first_move = false
      super_response
    end

    def can_make_castling?
      @first_move
    end

    private

    def generate_deltas
      (MIN_INDEX..MAX_INDEX).each do |i|
        next if i == MIN_INDEX

        @generated_deltas[:v1].deltas << [0, i]
        @generated_deltas[:v2].deltas << [i, 0]
        @generated_deltas[:v3].deltas << [0, -i]
        @generated_deltas[:v4].deltas << [-i, 0]
      end

      @capture_movements = @generated_deltas
    end
  end
end
