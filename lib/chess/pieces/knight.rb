require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Knight < Piece
    POSITION_DELTAS = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]].freeze
    CAPTURE_MOVEMENTS = POSITION_DELTAS
    SYMBOL = :N

    def initialize(position_algebraic, team)
      super(position_algebraic, SYMBOL, team)
    end

    def move_to(position_algebraic, capturing = false)
      super(position_algebraic, capturing ? CAPTURE_MOVEMENTS : POSITION_DELTAS)
    end
  end
end
