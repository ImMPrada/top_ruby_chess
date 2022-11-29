require 'colorize'
require 'colorized_string'

require_relative '../core/chess'

module Chess
  module CLI
    class Render
      def initialize
        @records_history = nil
      end

      def ask_for_prompt
        puts 'make your move:'
      end

      def header(board)
        puts "\n"
        puts "\n"
        puts board
        puts "\n"
        puts "  \u00bb #{@current_player} \u00ab  ".black.on_red if @current_player == BLACK_TEAM
        puts "  \u00bb #{@current_player} \u00ab  ".light_white.on_light_red if @current_player == WHITE_TEAM
      end

      def current_player(player)
        @current_player = player
      end

      def show_record
        puts "RECORD\n"
        line = 0

        historic_string = @records_history.map do |play_record|
          line += 1
          "#{line}. #{play_record}\n"
        end

        puts historic_string.join

        @records_history = nil
      end

      def update_records_history(records_history)
        @records_history = records_history
      end
    end
  end
end
