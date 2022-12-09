require_relative 'core/constants'
require_relative 'core/board'
require_relative 'core/book'
require_relative 'cli/prompt'
require_relative 'cli/render'

require 'byebug'

module Chess
  class Game
    include Chess::Core::Constants

    def start
      instantiate_components
      @state = GAME_RUNNING

      game_loop
    end

    def game_loop
      while @state == GAME_RUNNING
        @render.update_records_history(@book.record.history)
        @render.header(@board)
        puts @current_player

        response = decision_prompt

        puts response
        if response == COMMIT_SUCCESS
          change_roles
          next
        end
        next if response == COMMAND_SUCCES

        puts 'BAD WAY'
      end
    end

    private

    def instantiate_components
      @current_player = WHITE_TEAM
      @current_enemy = BLACK_TEAM
      @state = nil

      @board = Chess::Core::Board.new
      @book = Chess::Core::Book.new(@board)
      @prompt = Chess::CLI::Prompt.new
      @render = Chess::CLI::Render.new
      @render.update_current_player(@current_player)

      @history = []
    end

    def change_roles
      current_player = @current_player

      @current_player = @current_enemy
      @current_enemy = current_player
      @render.update_current_player(@current_player)
    end

    def decision_prompt
      @render.ask_for_prompt
      execute(@prompt.input(gets.chomp))
    end

    def execute(intention_case)
      @history << "#{@current_player}: #{@prompt.input_string}  -- #{@prompt.case} | #{@prompt.parameters}"

      case intention_case
      when ERR_WRONG_INPUT
        decision_prompt
      when CASE_MOVE
        run_move
      when CASE_CASTLE
        run_castle
      when SHOW_RECORD_COMMAD
        run_show_record
      when EXIT_COMMAD
        run_exit
      end
    end

    def run_move
      byebug
    end

    def run_castle
      castling_side = @prompt.parameters

      @book.castle_intention_on(castling_side, @current_player)
    end

    def run_show_record
      @render.show_record

      COMMAND_SUCCES
    end

    def run_exit
      @state = STOP
      instantiate_components

      COMMAND_SUCCES
    end
  end
end
