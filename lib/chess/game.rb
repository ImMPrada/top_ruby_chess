require_relative 'core/constants'
require_relative 'core/board'
require_relative 'core/book'
require_relative 'cli/prompt'
require_relative 'cli/render'

module Chess
  class Game
    include Chess::Core::Constants

    Intention = Struct.new(:type, :origin_cell, :target_cell, keyword_init: true)

    def start
      instantiate_components
      @state = GAME_RUNNING

      game_loop
    end

    def game_loop
      while @state == GAME_RUNNING
        @render.update_records_history(@book.record.history)
        @render.board_state(@board)

        response = decision_prompt

        if response == COMMIT_SUCCESS
          change_roles
          next
        end
        next if response == COMMAND_SUCCES
      end
    end

    private

    def instantiate_components
      @current_player = WHITE_TEAM
      @current_enemy = BLACK_TEAM
      @state = nil

      @board = Chess::Core::Board.create_and_occupy
      @book = Chess::Core::Book.new(@board)
      @prompt = Chess::CLI::Prompt.new
      @render = Chess::CLI::Render.new
      @render.update_current_player(@current_player)
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
      prompt_parameters = @prompt.parameters

      from_cartesian = prompt_parameters.from.to_cartesian
      to_cartesian = prompt_parameters.to.to_cartesian

      intention = Intention.new(
        type: INTENTION_IS_MOVE,
        origin_cell: @board.cell_at_cartesian(from_cartesian),
        target_cell: @board.cell_at_cartesian(to_cartesian)
      )

      @book.move(intention, @current_player)
    end

    def run_castle
      prompt_parameters = @prompt.parameters

      intention = Intention.new(type: prompt_parameters)

      @book.move(intention, @current_player)
    end

    def run_show_record
      @render.show_record

      COMMAND_SUCCES
    end

    def run_exit
      @state = GAME_STOP
      instantiate_components

      COMMAND_SUCCES
    end
  end
end
