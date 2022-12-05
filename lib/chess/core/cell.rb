require 'colorize'
require 'colorized_string'

require_relative './constants'
require_relative '../functional/cell_notation'

module Chess
  module Core
    class Cell
      attr_reader :occupant, :name

      include Chess::Functional::CellNotation
      include Chess::Constants

      def initialize(name, fill_color)
        @occupant = nil
        @fill_color = fill_color
        @name = name
      end

      def occupy_with(piece)
        @occupant = piece
      end

      def release
        @occupant = nil
      end

      def occupied?
        !!@occupant
      end

      def team
        return unless occupied?

        @occupant.team
      end

      def algebraic
        splitted_name = @name.split('')

        Algebraic.new(splitted_name[0], splitted_name[1].to_i)
      end

      def cartesian
        Cartesian.new(COLUMNS.index(algebraic.column), algebraic.row - 1)
      end
    end
  end
end
