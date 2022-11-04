require_relative 'chess'
require_relative 'piece'
require 'byebug'

module Chess
  class King < Piece
    POSITION_DELTAS = [[0, 1], [1, 1], [1, 0] [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]].freeze
    CAPTURE_MOVEMENTS = POSITION_DELTAS
    SYMBOL = :K

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
    end

    def move_to(position)
      super(position, POSITION_DELTAS)
    end
  end
end
