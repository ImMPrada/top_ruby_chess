require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Pawn < Piece
    SYMBOL = :P

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = { v1: Vector.new(true, []) }
      @capture_movements = { v1: Vector.new(true, []) }
      @first_move = true
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      generate_deltas
      @first_move = false if @first_move

      super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
    end

    private

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      @generated_deltas[:v1].deltas = []
      @capture_movements[:v1].deltas = []

      @generated_deltas[:v1].deltas << [0, 1]
      @capture_movements[:v1].deltas << [1, 1]
      @capture_movements[:v1].deltas << [-1, 1]

      return unless @first_move

      @generated_deltas[:v1].deltas << [0, 2]
      @capture_movements[:v1].deltas << [0, 2]
    end
    # rubocop:enable Metrics/AbcSize
  end
end
