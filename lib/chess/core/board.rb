require_relative 'constants'
require_relative 'cell'
require_relative 'board_pieces'
require_relative '../functional/target_cell_moves'

module Chess
  module Core
    class Board
      attr_reader :cells, :pieces

      include Chess::Functional::TargetCellMoves
      include Chess::Core::Constants

      Teams = Struct.new(:white, :black) do
        def empty?
          white.nil? && black.nil?
        end
      end

      def self.create_and_occupy
        board = new
        board.generate_cells
        board.put_pieces

        board
      end

      def initialize
        @cells = []
        @pieces = Teams.new(
          Chess::Core::BoardPieces.new,
          Chess::Core::BoardPieces.new
        )
      end

      def generate_cells
        cell_color = BLACK_TEAM

        (MIN_INDEX..MAX_INDEX).each do |row_index|
          cell_color = cell_color == WHITE_TEAM ? BLACK_TEAM : WHITE_TEAM
          @cells << []

          (MIN_INDEX..MAX_INDEX).each do |column_index|
            @cells[row_index] << Cell.new(
              "#{COLUMNS[column_index]}#{row_index + 1}",
              cell_color
            )
            cell_color = cell_color == WHITE_TEAM ? BLACK_TEAM : WHITE_TEAM
          end
        end
      end

      def put_pieces
        @pieces.white.put_pieces(@cells, WHITE_TEAM)
        @pieces.black.put_pieces(@cells, BLACK_TEAM)
      end

      def cell_at_cartesian(cartesian)
        @cells.dig(cartesian.row, cartesian.column)
      end
    end
  end
end
