require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class Queen < Piece
    SYMBOL = :Q

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = generate_deltas
      @capture_movements = @generated_deltas
    end

    def move_to(position)
      super(position, @generated_deltas)
    end

    def generate_deltas
      deltas = []

      (1..7).each do |i|
        deltas << [0, i]
        deltas << [i, i]
        deltas << [i, 0]
        deltas << [i, -i]
        deltas << [0, -i]
        deltas << [-i, -i]
        deltas << [-i, 0]
        deltas << [-i, i]
      end

      deltas
    end
  end
end
