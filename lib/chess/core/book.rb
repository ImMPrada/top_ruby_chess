require_relative 'constants'
require_relative 'record'
require_relative 'board'
require_relative './move/main'

module Chess
  module Core
    class Book
      attr_reader :record

      include Chess::Core::Constants

      def initialize(board)
        @board = board
        @record = Chess::Core::Record.new
        @move = Chess::Core::Move::Main
      end

      def move(intention, team_playing)
        capture = intention.target_cell.occupied? if intention.type == MOVE_INTENTION
        move = @move.new(
          intention,
          @board,
          team_playing
        )
        move_result = move.run
        return move_result unless move_result == COMMIT_SUCCESS

        @record.add_move(intention, team_playing, capture)
      end
    end
  end
end
