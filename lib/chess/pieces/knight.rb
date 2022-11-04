require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Knight < Piece
    POSITION_DELTAS = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]].freeze
    CAPTURE_MOVEMENTS = POSITION_DELTAS
    SYMBOL = :N

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
    end

    def move_to(position)
      super(position, POSITION_DELTAS)
    end
  end
end
