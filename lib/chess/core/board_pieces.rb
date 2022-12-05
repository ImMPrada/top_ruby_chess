require_relative 'constants'
require_relative 'cell'
require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/bishop'
require_relative './pieces/knight'
require_relative './pieces/rook'
require_relative './pieces/pawn'
require_relative '../functional/target_cell_moves'

module Chess
  module Core
    class BoardPieces
      attr_reader :king, :queens, :bishops, :knights, :rooks, :pawns

      include Chess::Constants

      def initialize
        @cells = nil
        @king = nil
        @queens = []
        @bishops = []
        @knights = []
        @rooks = []
        @pawns = []
      end

      def put_pieces(cells, team)
        @cells = cells
        generate_pieces(team)
      end

      def nil?
        @king.nil? && @queens.empty? && @bishops.empty? && @knights.empty? && @rooks.empty? && @pawns.empty?
      end

      def all
        [
          *@queens,
          *@bishops,
          *@knights,
          *@rooks,
          *@pawns
        ].reject(&:captured?)
      end

      def captured
        [
          *@queens,
          *@bishops,
          *@knights,
          *@rooks,
          *@pawns
        ].select(&:captured?)
      end

      def king_side_rook
        @rooks.find { |rook| !rook.captured? && rook.king_side? }
      end

      def queen_side_rook
        @rooks.find { |rook| !rook.captured? && rook.queen_side? }
      end

      private

      def generate_pieces(team)
        main_index = team == WHITE_TEAM ? 0 : 7
        pawns_index = team == WHITE_TEAM ? 1 : 6

        @king = Core::Pieces::King.create_and_occupy(team, @cells[main_index][4])
        @queens = create_queens(team, main_index)
        @bishops = create_bishops(team, main_index)
        @knights = create_knights(team, main_index)
        @rooks = create_rooks(team, main_index)
        @pawns = create_pawns(team, pawns_index)
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
        (0..7).map do |column_index|
          Core::Pieces::Pawn.create_and_occupy(team, @cells[pawns_index][column_index])
        end
      end
    end
  end
end
