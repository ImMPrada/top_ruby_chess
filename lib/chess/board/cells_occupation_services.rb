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
  end
end
