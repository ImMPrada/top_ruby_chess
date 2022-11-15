require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class King < Piece
    POSITION_DELTAS = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]].freeze
    CAPTURE_MOVEMENTS = POSITION_DELTAS
    SYMBOL = :K

    def initialize(position_algebraic, team)
      super(position_algebraic, SYMBOL, team)
    end

    def move_to(position_algebraic, capturing = false)
      super(position_algebraic, capturing ? CAPTURE_MOVEMENTS : POSITION_DELTAS)
    end
  end
end
