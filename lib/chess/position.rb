module Chess
  class Position
    attr_reader :row, :column, :algebraic, :coordinates

    COLUMNS = %w[a b c d e f g h].freeze

    Algebraic = Struct.new(:row, :column) do
      def to_s
        "#{column}#{row}"
      end
    end

    Coordinates = Struct.new(:row, :column) do
      def to_a
        [row, column]
      end
    end

    def initialize(algebraic_notation)
      @splitted_input = algebraic_notation.split('')
      set_value
    end

    def change(algebraic_notation)
      @splitted_input = algebraic_notation.split('')
      set_value
    end

    private

    def set_value
      @algebraic = Algebraic.new(@splitted_input[1].to_i, @splitted_input[0])
      @coordinates = Coordinates.new(@algebraic.row - 1, COLUMNS.index(@algebraic.column))
    end
  end
end
