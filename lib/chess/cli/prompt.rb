require_relative '../core/constants'
require_relative '../functional/cell_notation'

module Chess
  module CLI
    class Prompt
      attr_reader :input_string, :case, :parameters

      include Chess::Core::Constants
      include Chess::Functional::CellNotation

      MoveParameters = Struct.new(:piece, :from, :to)

      PIECE_MOVE_REGEX = /^[k, q, b, n, r, p]([a-h][1-8]){2}$/
      COMMANDS = {
        show_record: '--show-history',
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
          @parameters = nil
          @case = SHOW_RECORD_COMMAD
        when COMMANDS[:exit]
          @parameters = nil
          @case = EXIT_COMMAD
        end
      end

      def run_move
        case @input_string
        when PIECE_MOVE_REGEX
          build_move_response
        when QUEEN_SIDE_CASTLING_CODE
          @parameters = INTENTION_IS_QUEEN_CASTLING
          @case = CASE_CASTLE
        when KING_SIDE_CASTLING_CODE
          @parameters = INTENTION_IS_KING_CASTLING
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

      def build_move_response
        splitted_input_string = @input_string.split('')
        @parameters = MoveParameters.new(
          splitted_input_string[0],
          string_name_to_algebraic(splitted_input_string[1..2].join),
          string_name_to_algebraic(splitted_input_string[3..].join)
        )
        @case = CASE_MOVE
      end
    end
  end
end
