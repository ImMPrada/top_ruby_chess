require 'colorize'
require 'colorized_string'

require_relative '../core/constants'

module Chess
  module CLI
    class Render
      include Chess::Core::Constants

      def initialize
        @current_player = nil
        @records_history = []
      end

      def ask_for_prompt
        puts 'make your move:'
      end

      def board_state(board)
        puts "\n"
        puts "\n"
        puts board_to_string(board)
        puts "\n"
        puts "  \u00bb #{@current_player} \u00ab  ".black.on_red if @current_player == BLACK_TEAM
        puts "  \u00bb #{@current_player} \u00ab  ".light_white.on_light_red if @current_player == WHITE_TEAM
      end

      def print_records_history
        history = ''
        row = 1
        @records_history.each do |record|
          history += "#{row}. #{record_to_string(record.white)}   #{record_to_string(record.black)}\n"
          row += 1
        end

        puts history
      end

      def update_current_player(player)
        @current_player = player
      end

      def update_records_history(records_history)
        @records_history = records_history
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

      def record_to_string(record)
        response_string = ''
        return response_string unless record

        response_string += base_move_to_string(record)
        response_string += check_or_mate_to_string(record)
        response_string += draw_to_string(record)

        response_string + castle_to_string(record)
      end

      def base_move_to_string(record)
        piece = record.piece == :P ? '' : record.piece.to_s
        origin = record.origin || ''
        target = record.target || ''
        capturing = record.capture ? 'x' : ''

        piece + origin + capturing + target
      end

      def check_or_mate_to_string(record)
        check = record.check ? '+' : ''
        checkmate = record.checkmate ? '#' : ''

        check + checkmate
      end

      def castle_to_string(record)
        return '' unless record.castling
        return KING_SIDE_CASTLING_CODE.upcase if record.castling == INTENTION_IS_KING_CASTLING

        QUEEN_SIDE_CASTLING_CODE.upcase
      end

      def draw_to_string(record)
        record.draw ? '1/2-1/2' : ''
      end
    end
  end
end
