module Chess
  module CheckAttacksService
    # rubocop:disable Metrics/AbcSize
    def can_any_enemy_attack_to?(evaluated_cell_algebraic, enemy_team)
      return true if check_atack_hability_for([@pieces[enemy_team].king], evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)
      return true if check_atack_hability_for(@pieces[enemy_team].queens, evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)
      return true if check_atack_hability_for(@pieces[enemy_team].bishops, evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)
      return true if check_atack_hability_for(@pieces[enemy_team].knights, evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)
      return true if check_atack_hability_for(@pieces[enemy_team].rooks, evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)
      return true if check_atack_hability_for(@pieces[enemy_team].pawns, evaluated_cell_algebraic,
                                              occuped_cells_coordinates_by_teams)

      false
    end

    private

    def check_atack_hability_for(pieces, evaluated_cell_algebraic, occuped_cells)
      pieces_result = pieces.map do |piece|
        return true if piece.can_attack_to?(evaluated_cell_algebraic, occuped_cells)
      end

      !pieces_result.compact.empty?
    end

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
      cell = @cells[piece.position.algebraic.column.to_sym][piece.position.coordinates.row]

      cell.occup_by(piece)
    end
  end
end
