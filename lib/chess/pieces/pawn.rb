require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Pawn < Piece
    POSITION_DELTAS = [[0, 1]].freeze
    CAPTURE_MOVEMENTS = [[1, 1], [-1, 1]].freeze
    SYMBOL = :P

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @first_move = true
    end

    def move_to(position)
      if @first_move
        super(position, POSITION_DELTAS + [[0, 2]])
      else
        super(position, POSITION_DELTAS)
      end

      @first_move = false
    end
  end
end
