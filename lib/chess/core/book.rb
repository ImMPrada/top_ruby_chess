require_relative 'constants'
require_relative 'record'
require_relative 'board'
require_relative 'move/main'

module Chess
  module Core
    class Book
      attr_reader :record

      include Chess::Core::Constants

      def initialize(board)
        @board = board
        @record = Chess::Core::Record.new
      end

      def move(intention, team_playing)
        capture = intention.target_cell.occupied? if intention.type == MOVE_INTENTION
        move = Chess::Core::Move::Main.new(
          intention,
          @board,
          team_playing
        )
        move_result = move.run
        return move_result unless move_result == COMMIT_SUCCESS

        @record.add(intention, team_playing, capture)
        move_result
      end
    end
  end
end
