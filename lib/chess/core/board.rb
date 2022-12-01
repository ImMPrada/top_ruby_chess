require_relative 'chess'
require_relative 'cell'
require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/bishop'
require_relative './pieces/knight'
require_relative './pieces/rook'
require_relative './pieces/pawn'

module Chess
  module Core
    class Board
      attr_reader :cells, :pieces

      Pieces = Struct.new(:king, :queens, :bishops, :knights, :rooks, :pawns) do
        def to_a
          [king, *queens, *bishops, *knights, *rooks, *pawns]
        end

        def find_pieces_of(target_symbol)
          to_a.select { |piece| piece.symbol == target_symbol }
        end

        def all
          to_a.reject(&:captured?)
        end
      end

      def self.create_and_occupy
        this_board = new
        this_board.generate_cells
        this_board.put_pieces

        this_board
      end

      def initialize
        @cells = []
        @pieces = nil
      end

      def generate_cells
        cell_color = BLACK_TEAM

        (MIN_INDEX..MAX_INDEX).to_a.each do |row_index|
          @cells << []

          (MIN_INDEX..MAX_INDEX).to_a.each do |column_index|
            @cells[row_index] << Cell.new(
              "#{COLUMNS[column_index]}#{row_index + 1}",
              cell_color
            )
            cell_color = cell_color == WHITE_TEAM ? BLACK_TEAM : WHITE_TEAM
          end
        end
      end

      def put_pieces
        @pieces = {
          WHITE_TEAM => generate_pieces(WHITE_TEAM),
          BLACK_TEAM => generate_pieces(BLACK_TEAM)
        }
      end

      private

      def generate_pieces(team)
        main_index = team == WHITE_TEAM ? 0 : 7
        pawns_index = team == WHITE_TEAM ? 1 : 6

        Pieces.new(
          Core::Pieces::King.create_and_occupy(team, @cells[main_index][4]),
          create_queens(team, main_index),
          create_bishops(team, main_index),
          create_knights(team, main_index),
          create_rooks(team, main_index),
          create_pawns(team, pawns_index)
        )
      end

      def create_queens(team, main_index)
        [
          Core::Pieces::Queen.create_and_occupy(team, @cells[main_index][3])
        ]
      end

      def create_bishops(team, main_index)
        [
          Core::Pieces::Bishop.create_and_occupy(team, @cells[main_index][2]),
          Core::Pieces::Bishop.create_and_occupy(team, @cells[main_index][5])
        ]
      end

      def create_knights(team, main_index)
        [
          Core::Pieces::Knight.create_and_occupy(team, @cells[main_index][1]),
          Core::Pieces::Knight.create_and_occupy(team, @cells[main_index][6])
        ]
      end

      def create_rooks(team, main_index)
        [
          Core::Pieces::Rook.create_and_occupy(team, @cells[main_index][0]),
          Core::Pieces::Rook.create_and_occupy(team, @cells[main_index][7])
        ]
      end

      def create_pawns(team, pawns_index)
        (0..7).to_a.map do |column_index|
          Core::Pieces::Pawn.create_and_occupy(team, @cells[pawns_index][column_index])
        end
      end
    end
  end
end
