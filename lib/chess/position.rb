require_relative 'chess'

module Chess
  class Position
    attr_reader :algebraic, :coordinates

    Algebraic = Struct.new(:column, :row) do
      def to_s
        "#{column}#{row}"
      end
    end

    Coordinates = Struct.new(:column, :row) do
      def to_a
        [column, row]
      end
    end

    def initialize(algebraic_notation)
      @splitted_input = algebraic_notation.split('')
      set_value
    end

    private

    def set_value
      @algebraic = Algebraic.new(@splitted_input[0], @splitted_input[1].to_i)
      @coordinates = Coordinates.new(COLUMNS.index(@algebraic.column), @algebraic.row - 1)
    end
  end
end
