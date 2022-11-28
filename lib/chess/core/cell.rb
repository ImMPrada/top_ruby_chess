require 'colorize'
require 'colorized_string'

require_relative './chess'

module Chess
  module Core
    class Cell
      attr_reader :algebraic, :coordinates

      Algebraic = Struct.new(:column, :row) do
        def to_s
          "#{column}#{row}"
        end
      end

      Coordinates = Struct.new(:column, :row) do
        def to_a
          [row, column]
        end
      end

      def initialize(name, fill_color, occupied = false, occupied_by = nil)
        @occupied = occupied
        @occupied_by = occupied_by
        @fill_color = fill_color
        @name = name

        set_nomenclature_values
      end

      def occupy_with(piece)
        @occupied = true
        @occupied_by = piece
      end

      def free
        @occupied = false
        @occup_by = nil
      end

      def occupant
        @occupied_by
      end

      def occupied?
        @occupied
      end

      def team
        return unless occupied?

        @occupied_by.team
      end

      def to_s
        in_cell = '   '
        in_cell = @occupied_by.to_s if occupied?

        return in_cell.on_light_red if @fill_color == WHITE_TEAM

        in_cell.on_red if @fill_color == BLACK_TEAM
      end

      def self.all
        ObjectSpace.each_object(self).to_a
      end

      def self.all_occupied
        all.select(&:occupied?)
      end

      private

      def set_nomenclature_values
        splitted_name = @name.split('')
        @algebraic = Algebraic.new(splitted_name[0], splitted_name[1].to_i)
        @coordinates = Coordinates.new(COLUMNS.index(@algebraic.column), @algebraic.row - 1)
      end
    end
  end
end
