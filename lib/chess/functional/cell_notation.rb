require_relative '../core/constants'

module Chess
  module Functional
    module CellNotation
      include Chess::Core::Constants

      Algebraic = Struct.new(:column, :row) do
        def to_s
          "#{column}#{row}"
        end

        def to_cartesian
          Cartesian.new(COLUMNS.index(column), row - 1)
        end
      end

      Cartesian = Struct.new(:column, :row) do
        def to_a
          [row, column]
        end
      end

      def algebraic_to_cartesian_a(name)
        splitted_name = name.split('')

        Algebraic.new(splitted_name[0], splitted_name[1].to_i)
      end
    end
  end
end
