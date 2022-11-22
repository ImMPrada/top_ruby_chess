module Chess
  module CheckAttacksService
    def can_any_enemy_attack_to?(target_cell_string, enemy_team, occuped_cells)
      evaluation = @pieces[enemy_team].to_a.map do |pieces|
        check_atack_hability_for(pieces, target_cell_string, occuped_cells)
      end

      evaluation.any?(true)
    end

    private

    def check_atack_hability_for(pieces, target_cell_string, occuped_cells)
      pieces_result = pieces.map do |piece|
        return true if piece.can_attack_to?(target_cell_string, occuped_cells)
      end

      !pieces_result.compact.empty?
    end

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
