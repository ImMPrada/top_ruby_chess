require_relative 'chess'

module Chess
  class Prompt
    attr_reader :input_string, :case, :parameters

    PIECE_MOVE_REGEX = /^[k, q, b, n, r, p]([a-h][1-8]){2}$/
    PIECE_MOVE_SCAN_REGEX = /[k, q, b, n, r, p]|[a-h][1-8]/
    QUEEN_SIDE_CASTLE_INPUT = 'o-o-o'.freeze
    KING_SIDE_CASTLE_INPUT = 'o-o'.freeze

    def initialize
      @input_string = nil
      @case = nil
      @parameters = nil
    end

    def input(input_string)
      @input_string = input_string.downcase

      return run_command if command_prompt?
      return run_move if moving_prompt?

      @input_string = nil
      ERR_WRONG_INPUT
    end

    private

    def run_move
      case @input_string
      when PIECE_MOVE_REGEX
        @parameters = @input_string.scan(PIECE_MOVE_SCAN_REGEX)
        @case = CASE_MOVEMENT
      when QUEEN_SIDE_CASTLE_INPUT
        @parameters = QUEEN_SIDE
        @case = CASE_CASTLE
      when KING_SIDE_CASTLE_INPUT
        @parameters = KING_SIDE
        @case = CASE_CASTLE
      end
    end

    def command_prompt?
      @input_string.match?(/^--[a-z]*/)
    end

    def moving_prompt?
      return true if @input_string.match?(PIECE_MOVE_REGEX)
      return true if @input_string == QUEEN_SIDE_CASTLE_INPUT || @input_string == KING_SIDE_CASTLE_INPUT
    end
  end
end
