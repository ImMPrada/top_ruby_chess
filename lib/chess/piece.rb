module Chess
  class Piece
    CAPTURE_REGEX = 'x'.freeze
    COLUMNS = %w[a b c d e f g h].freeze

    def initialize(coordinates, symbol)
      @position = Node.new(coordinates)
      @symbol = symbol
    end

    def transpile_algebraic_notation_to_coordinates(algebraic_notation)
      algebraic_notation = algebraic_notation.split('')

      column = COLUMNS.index(algebraic_notation[0])
      row = algebraic_notation[1].to_i - 1

      [row, column]
    end

    def possible_positions(position_deltas)
      position_deltas.map { |delta| possible_move(@position.coordinates, delta) }.compact
    end

    def possible_move(position, delta)
      move_to = [position[0] + delta[0], position[1] + delta[1]]

      return nil if move_to[0] < MIN_INDEX || move_to[0] > MAX_INDEX
      return nil if move_to[1] < MIN_INDEX || move_to[1] > MAX_INDEX

      move_to
    end
  end
end
