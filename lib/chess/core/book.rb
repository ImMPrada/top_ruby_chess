require_relative 'chess'
require_relative 'record'
require_relative 'board'
require_relative './move/main'

module Chess
  module Core
    class Book
      attr_reader :record

      def initialize(board)
        @board = board
        @cells = @board.cells
        @pieces = @board.pieces
        @record = Chess::Core::Record.new
        @move = Chess::Core::Move::Main
      end

      def move_intention; end

      def castle_intention_on; end
    end
  end
end
