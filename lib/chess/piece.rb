module Chess
  class Piece
    CAPTURE_REGEX = 'x'.freeze
    COLUMNS = %w[a b c d e f g h].freeze

    def initialize(coordinates, symbol)
      @position = Node.new(coordinates)
      @symbol = symbol
    end
  end
end
