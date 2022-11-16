require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Pawn < Piece
    POSITION_DELTAS = [[0, 1]].freeze
    CAPTURE_MOVEMENTS = [[1, 1], [-1, 1]].freeze
    SYMBOL = :P

    def initialize(position_algebraic, team)
      super(position_algebraic, SYMBOL, team)
      @first_move = true
    end

    def move_to(position_algebraic, capturing = false)
      if @first_move
        @first_move = false
        return super(position_algebraic, capturing ? CAPTURE_MOVEMENTS : POSITION_DELTAS + [[0, 2]])
      end

      super(position_algebraic, capturing ? CAPTURE_MOVEMENTS : POSITION_DELTAS)
    end
  end
end
