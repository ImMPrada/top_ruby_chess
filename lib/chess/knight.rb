require_relative 'chess'
require_relative 'node'
require_relative '../fake_queue'

module Chess
  class Knight
    KNIGHT_POSITION_DELTAS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]].freeze

    def initialize(coordinates)
      @position = Node.new(coordinates)
    end
  end
end
