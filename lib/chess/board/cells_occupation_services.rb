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
  end
end
