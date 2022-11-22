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
      super_response = super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
      return unless super_response

      @first_move = false
      super_response
    end

    def can_attack_to?(target_position_algebraic, occuped_cells)
      generate_deltas
      can_move_to?(target_position_algebraic, @capture_movements, occuped_cells)
    end

    def to_s
      super("\u265f")
    end

    private

    def generate_deltas
      return generate_white_deltas if @team == WHITE_TEAM
      return generate_black_deltas if @team == BLACK_TEAM
    end

    def generate_white_deltas
      @generated_deltas[:v1].deltas = []
      @capture_movements[:v1].deltas = []

      @generated_deltas[:v1].deltas << [0, 1]
      @capture_movements[:v1].deltas << [1, 1]
      @capture_movements[:v1].deltas << [-1, 1]

      return unless @first_move

      @generated_deltas[:v1].deltas << [0, 2]
    end

    def generate_black_deltas
      @generated_deltas[:v1].deltas = []
      @capture_movements[:v1].deltas = []

      @generated_deltas[:v1].deltas << [0, -1]
      @capture_movements[:v1].deltas << [1, -1]
      @capture_movements[:v1].deltas << [-1, -1]

      return unless @first_move

      @generated_deltas[:v1].deltas << [0, -2]
    end
  end
end
