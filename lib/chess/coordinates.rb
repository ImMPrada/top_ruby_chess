module Chess
  class Coordinates
    attr_reader :row, :column, :algebraic_notation

    COLUMNS = %w[a b c d e f g h].freeze

    def initialize(algebraic_notation)
      @algebraic_notation = algebraic_notation
    end

    def change(algebraic_notation)
      @algebraic_notation = algebraic_notation
      generate_array_of_coordinates
    end

    def array_notation
      return generate_array_of_coordinates if @row.nil? || @column.nil?

      [@row, @column]
    end
  end

  private

  def generate_array_of_coordinates
    algebraic_notation = @algebraic_notation.split('')

    @column = COLUMNS.index(algebraic_notation[0])
    @row = algebraic_notation[1].to_i - 1

    [@row, @column]
  end
end
