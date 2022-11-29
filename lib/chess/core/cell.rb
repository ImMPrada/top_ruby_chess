require 'colorize'
require 'colorized_string'

require_relative './chess'

module Chess
  module Core
    class Cell
      attr_reader :occupant

      Algebraic = Struct.new(:column, :row) do
        def to_s
          "#{column}#{row}"
        end
      end

      def initialize(name, fill_color)
        @occupied = false
        @occupant = nil
        @fill_color = fill_color
        @name = name
      end

      def occupy_with(piece)
        @occupied = true
        @occupant = piece
      end

      def release
        @occupied = false
        @occupant = nil
      end

      def occupied?
        @occupied
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
        [algebraic.row - 1, COLUMNS.index(algebraic.column)]
      end
    end
  end
end
