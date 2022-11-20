require_relative 'chess'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/rook'
require_relative 'pieces/pawn'

module Chess
  class Board
    attr_reader :cells, :pieces

    Cell = Struct.new(:algebraic_notation, :occuped, :occuped_by, :team, :coordinates_notation)

    Pieces = Struct.new(:team, :king, :queens, :bishops, :knights, :rooks, :pawns)

    def initialize
      @cells = {}
      @pieces = nil

      generate_cells
      put_pieces
    end

    def occuped_cells
      occuped_cells = {
        WHITE_TEAM => [],
        BLACK_TEAM => []
      }

      COLUMNS.each do |column|
        (MIN_INDEX..MAX_INDEX).each do |row_index|
          row = row_index + 1
          @cells[column.to_sym]

          cell = @cells[column.to_sym][row]
          next unless cell.occuped

          occuped_cells[cell.team] << cell.coordinates_notation
        end
      end

      occuped_cells
    end

    # rubocop:disable Metrics/AbcSize
    def can_any_enemy_attack_to?(evaluated_cell_algebraic, enemy_team)
      return true if check_atack_hability_for([@pieces[enemy_team].king], evaluated_cell_algebraic, occuped_cells)
      return true if check_atack_hability_for(@pieces[enemy_team].queens, evaluated_cell_algebraic, occuped_cells)
      return true if check_atack_hability_for(@pieces[enemy_team].bishops, evaluated_cell_algebraic, occuped_cells)
      return true if check_atack_hability_for(@pieces[enemy_team].knights, evaluated_cell_algebraic, occuped_cells)
      return true if check_atack_hability_for(@pieces[enemy_team].rooks, evaluated_cell_algebraic, occuped_cells)
      return true if check_atack_hability_for(@pieces[enemy_team].pawns, evaluated_cell_algebraic, occuped_cells)

      false
    end
    # rubocop:enable Metrics/AbcSize

    private

    def check_atack_hability_for(pieces, evaluated_cell_algebraic, occuped_cells)
      pieces_result = pieces.map do |piece|
        piece.can_attack_to?(evaluated_cell_algebraic, occuped_cells)
      end
      !pieces_result.compact.empty?
    end

    def generate_cells
      COLUMNS.each do |column|
        @cells[column.to_sym] = {}
        (MIN_INDEX..MAX_INDEX).each do |row_index|
          row = row_index + 1
          @cells[column.to_sym][row] = Cell.new("#{column}#{row}", false, nil, nil, [COLUMNS.index(column), row_index])
        end
      end
    end

    def put_pieces
      @pieces = {
        WHITE_TEAM => generate_pieces(WHITE_TEAM, 2),
        BLACK_TEAM => generate_pieces(BLACK_TEAM, 7)
      }

      take_cells
    end

    def generate_pieces(team, row_of_pawns)
      main_row = main_row(team, row_of_pawns)

      Pieces.new(
        team,
        King.new("d#{main_row}", team),
        [Queen.new("e#{main_row}", team)],
        [Bishop.new("c#{main_row}", team), Bishop.new("f#{main_row}", team)],
        [Knight.new("b#{main_row}", team), Knight.new("g#{main_row}", team)],
        [Rook.new("a#{main_row}", team), Rook.new("h#{main_row}", team)],
        (0..7).to_a.map { |column_index| Pawn.new("#{COLUMNS[column_index]}#{row_of_pawns}", team) }
      )
    end

    def main_row(team, row_of_pawns)
      return row_of_pawns + 1 if team == BLACK_TEAM

      row_of_pawns - 1
    end

    def take_cells
      take_cells_by_team(WHITE_TEAM)
      take_cells_by_team(BLACK_TEAM)
    end

    # rubocop:disable Metrics/AbcSize
    def take_cells_by_team(team)
      take_cell_by(@pieces[team].king)
      @pieces[team].queens.each { |queen| take_cell_by(queen) }
      @pieces[team].bishops.each { |bishop| take_cell_by(bishop) }
      @pieces[team].knights.each { |knight| take_cell_by(knight) }
      @pieces[team].rooks.each { |rook| take_cell_by(rook) }
      @pieces[team].pawns.each { |pawn| take_cell_by(pawn) }
    end
    # rubocop:enable Metrics/AbcSize

    def take_cell_by(piece)
      algebraic_notation = piece.position.algebraic
      cell = @cells[algebraic_notation.column.to_sym][algebraic_notation.row]

      cell.team = piece.team
      cell.occuped = true
      cell.occuped_by = piece
    end
  end
end
