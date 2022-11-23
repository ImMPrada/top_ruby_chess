module Chess
  module CellsOccupationServices
    def occup_cells_by(team)
      @pieces[team].to_a.each { |pieces| occup_by(pieces) }
    end

    def occup_by(pieces)
      pieces.each { |queen| occup_cell_by(queen) }
    end

    def occup_cell_by(piece)
      cell = @cells[piece.position.algebraic.column.to_sym][piece.position.coordinates.row]

      cell.occup_by(piece)
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

    def find_cell(cell_algebraic_string)
      splitted_cell_string = cell_algebraic_string.split('')
      @cells[splitted_cell_string[0].to_sym][splitted_cell_string[1].to_i - 1]
    end

    def path_empty?(road_columns, row)
      road = road_columns.map do |road_column|
        cell = find_cell("#{road_column}#{row}")
        cell.occuped?
      end
      road.all?(false)
    end

    def king_side_castling_cells_free?(team)
      return path_empty?(%w[f g], MIN_INDEX + 1) if team == WHITE_TEAM
      return path_empty?(%w[f g], MAX_INDEX + 1) if team == BLACK_TEAM
    end

    def queen_side_castling_cells_free?(team)
      return path_empty?(%w[b c d], MIN_INDEX + 1) if team == WHITE_TEAM
      return path_empty?(%w[b c d], MAX_INDEX + 1) if team == BLACK_TEAM
    end
  end
end
