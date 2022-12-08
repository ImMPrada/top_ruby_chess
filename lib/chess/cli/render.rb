require 'colorize'
require 'colorized_string'

require_relative '../core/constants'

module Chess
  module CLI
    class Render
      include Chess::Core::Constants

      def initialize
        @current_player = nil
      end

      def ask_for_prompt
        puts 'make your move:'
      end

      def header(board)
        puts "\n"
        puts "\n"
        puts board_to_string(board)
        puts "\n"
        puts "  \u00bb #{@current_player} \u00ab  ".black.on_red if @current_player == BLACK_TEAM
        puts "  \u00bb #{@current_player} \u00ab  ".light_white.on_light_red if @current_player == WHITE_TEAM
      end

      def update_current_player(player)
        @current_player = player
      end

      private

      def board_to_string(board)
        headers = "    a  b  c  d  e  f  g  h    \n".yellow

        row = headers
        (MAX_INDEX..MIN_INDEX).step(-1).each do |row_index|
          row += " #{row_index + 1} ".yellow
          row_of_cells = board.cells[row_index]
          row_of_cells.each do |cell|
            row += cell_to_string(cell)
          end
          row += " #{row_index + 1} \n".yellow
        end

        row += headers
      end

      def cell_to_string(cell)
        return " #{piece_at(cell)} ".on_light_red if cell.fill_color == WHITE_TEAM

        " #{piece_at(cell)} ".on_red if cell.fill_color == BLACK_TEAM
      end

      def piece_at(cell)
        return ' ' unless cell.occupied?

        return PIECE_STRING[cell.occupant.symbol].to_s.white if cell.occupant.team == WHITE_TEAM

        PIECE_STRING[cell.occupant.symbol].to_s.black
      end
    end
  end
end
