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

      Pieces = Struct.new(:team, :king, :queens, :bishops, :knights, :rooks, :pawns) do
        def to_a
          [[king], queens, bishops, knights, rooks, pawns]
        end
      end

      def self.create_and_occupy
        this_board = new
        generate_cells
        put_pieces

        this_board
      end

      def initialize
        @cells = []
        @pieces = nil
      end

      def can_any_enemy_attack_to?(target_cell_string, enemy_team, occuped_cells)
        evaluation = @pieces[enemy_team].to_a.map do |pieces|
          check_atack_hability_for(pieces, target_cell_string, occuped_cells)
        end

        evaluation.any?(true)
      end

      def occuped_cells_coordinates_by_teams
        occuped_cells = {
          WHITE_TEAM => [],
          BLACK_TEAM => []
        }

        COLUMNS.each do |column|
          (MIN_INDEX..MAX_INDEX).each do |row_index|
            @cells[column.to_sym]

            cell = @cells[column.to_sym][row_index]
            next unless cell.occuped?

            occuped_cells[cell.team] << cell.coordinates.to_a
          end
        end

        occuped_cells
      end

      private

      def check_atack_hability_for(pieces, target_cell_string, occuped_cells)
        pieces_result = pieces.map do |piece|
          return true if piece.can_attack_to?(target_cell_string, occuped_cells)
        end

        !pieces_result.compact.empty?
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
          WHITE_TEAM => generate_pieces(WHITE_TEAM, 2),
          BLACK_TEAM => generate_pieces(BLACK_TEAM, 7)
        }

        occup_cells
      end

      def generate_pieces(team, row_of_pawns)
        main_row = main_row(team, row_of_pawns)

        Pieces.new(
          team,
          King.new("e#{main_row}", team),
          [Queen.new("d#{main_row}", team)],
          [Bishop.new("c#{main_row}", team), Bishop.new("f#{main_row}", team)],
          [Knight.new("b#{main_row}", team), Knight.new("g#{main_row}", team)],
          [Rook.new("a#{main_row}", team, QUEEN_SIDE), Rook.new("h#{main_row}", team, KING_SIDE)],
          (0..7).to_a.map { |column_index| Pawn.new("#{COLUMNS[column_index]}#{row_of_pawns}", team) }
        )
      end

      def main_row(team, row_of_pawns)
        return row_of_pawns + 1 if team == BLACK_TEAM

        row_of_pawns - 1
      end

      def occup_cells
        occup_cells_by(WHITE_TEAM)
        occup_cells_by(BLACK_TEAM)
      end

      def occup_cells_by(team)
        @pieces[team].to_a.each do |pieces|
          pieces.each { |piece| find_cell(piece.position.algebraic.to_s).occup_by(piece) }
        end
      end

      def find_cell(cell_algebraic_string)
        splitted_cell_string = cell_algebraic_string.split('')
        @cells[splitted_cell_string[0].to_sym][splitted_cell_string[1].to_i - 1]
      end
    end
  end
end
