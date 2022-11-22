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
  end
end
