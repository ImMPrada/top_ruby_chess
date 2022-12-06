require_relative '../core/constants'

module Chess
  module CLI
    class Prompt
      attr_reader :input_string, :case, :parameters

      include Chess::Core::Constants

      PIECE_MOVE_REGEX = /^[k, q, b, n, r, p]([a-h][1-8]){2}$/
      COMMANDS = {
        show_record: '--show-record',
        exit: '--exit'
      }.freeze

      def initialize
        @input_string = nil
        @case = nil
        @parameters = nil
      end

      def input(input_string)
        clear
        @input_string = input_string.downcase

        return run_command if command_prompt?
        return run_move if moving_prompt?

        @input_string = nil
        ERR_WRONG_INPUT
      end

      def clear
        @input_string = nil
        @case = nil
        @parameters = nil
      end

      private

      def run_command
        case @input_string
        when COMMANDS[:show_record]
          @case = SHOW_RECORD_COMMAD
        when COMMANDS[:exit]
          @case = EXIT_COMMAD
        end
      end

      def run_move
        case @input_string
        when PIECE_MOVE_REGEX
          splitted_input_string = @input_string.split('')
          @parameters = [splitted_input_string[0], splitted_input_string[1..2].join, splitted_input_string[3..].join]
          @case = CASE_MOVE
        when QUEEN_SIDE_CASTLING_CODE
          @parameters = QUEEN_SIDE
          @case = CASE_CASTLE
        when KING_SIDE_CASTLING_CODE
          @parameters = KING_SIDE
          @case = CASE_CASTLE
        end
      end

      def command_prompt?
        @input_string.match?(/^--[a-z]*/)
      end

      def moving_prompt?
        return true if @input_string.match?(PIECE_MOVE_REGEX)
        return true if @input_string == KING_SIDE_CASTLING_CODE || @input_string == QUEEN_SIDE_CASTLING_CODE
      end
    end
  end
end
