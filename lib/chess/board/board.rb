require_relative '../chess'
require_relative '../movement/movement'
require_relative 'cell'
require_relative 'check_attacks_services'
require_relative 'string_transform_services'
require_relative 'cells_occupation_services'
require_relative 'movement_services'

require_relative '../pieces/king'
require_relative '../pieces/queen'
require_relative '../pieces/bishop'
require_relative '../pieces/knight'
require_relative '../pieces/rook'
require_relative '../pieces/pawn'

module Chess
  class Board
    include CheckAttacksService
    include CellsOccupationServices
    include StringTransformServices
    include MovementServices

    attr_reader :cells, :pieces

    Pieces = Struct.new(:team, :king, :queens, :bishops, :knights, :rooks, :pawns) do
      def to_a
        [[king], queens, bishops, knights, rooks, pawns]
      end
    end

    def initialize
      @cells = {}
      @pieces = nil

      generate_cells
      put_pieces
    end

    private

    def generate_cells
      cell_color = WHITE_TEAM
      COLUMNS.each do |column|
        @cells[column.to_sym] = []
        cell_color = cell_color == BLACK_TEAM ? WHITE_TEAM : BLACK_TEAM
        (MIN_INDEX..MAX_INDEX).each do |row_index|
          row = row_index + 1
          @cells[column.to_sym] << Cell.new("#{column}#{row}", cell_color)

          cell_color = cell_color == BLACK_TEAM ? WHITE_TEAM : BLACK_TEAM
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
  end
end
