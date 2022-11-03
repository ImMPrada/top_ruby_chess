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
  end
end
