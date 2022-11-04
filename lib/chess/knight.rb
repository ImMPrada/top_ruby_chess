require_relative 'chess'
require_relative 'node'
require_relative 'piece'
require_relative '../fake_queue'
require 'byebug'

module Chess
  class Knight < Piece
    POSITION_DELTAS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]].freeze

    def initialize(coordinates)
      super(coordinates, :K)
    end

    def move_to(position)
      super(position, POSITION_DELTAS)
    end
  end
end
