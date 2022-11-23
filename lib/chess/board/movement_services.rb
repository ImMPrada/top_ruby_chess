require_relative '../chess'

module Chess
  module MovementServices
    def commit_movement_intention(piece_symbol, origin_cell, target_cell, team_filter)
      intention = { symbol: piece_symbol, origin_cell:, target_cell: }
      movement = Movement.new(intention, @cells, occuped_cells_coordinates_by_teams, @pieces, team_filter)

      submit_result = movement.submit
      return submit_result unless submit_result == SUBMIT_SUCCESS

      commit_result = movement.commit
      movement.update_occuped_cells(occuped_cells_coordinates_by_teams)

      if commit_result == COMMIT_SUCCESS
        king_in_risk = can_any_enemy_attack_to?(movement.king_position_string,
                                                movement.enemies_team,
                                                occuped_cells_coordinates_by_teams)
      end
      return commit_result unless king_in_risk

      movement.roll_back
    end

    def castle_intention_on(side, team)
      return king_side_castling_intention(team) if side == KING_SIDE
      return queen_side_castling_intention(team) if side == QUEEN_SIDE

      ERR_INTENTION_PARAMETERS
    end

    private

    def commit_castle_intention(king, rook)
      current_cells_occupation = occuped_cells_coordinates_by_teams

      king_movement = setup_king_movement_instance(king, rook, current_cells_occupation)

      king_submit_result = king_movement.castle_submit(rook)
      return king_submit_result unless king_submit_result == SUBMIT_SUCCESS

      commit_result = king_movement.castle_commit
      king_movement.update_occuped_cells(occuped_cells_coordinates_by_teams)

      if commit_result == COMMIT_SUCCESS
        king_in_risk = can_any_enemy_attack_to?(king_movement.king_position_string,
                                                king_movement.enemies_team,
                                                occuped_cells_coordinates_by_teams)
      end
      return commit_result unless king_in_risk

      king_movement.roll_back_castling
    end

    def setup_king_movement_instance(king, rook, current_cells_occupation)
      row = king.position.algebraic.row

      target_cell = "c#{row}" if rook.queen_side?
      target_cell = "g#{row}" if rook.king_side?

      intention = {
        symbol: king.symbol,
        origin_cell: king.position.algebraic.to_s,
        target_cell:
      }

      Movement.new(intention, @cells, current_cells_occupation, @pieces, king.team)
    end

    def king_side_castling_intention(team)
      king = @pieces[team].king

      empty_road = king_side_castling_cells_free?(team)
      rook = @pieces[team].rooks.select(&:king_side?).last

      return CANT_CASTLING unless empty_road && king.can_castling? && rook.can_castling?

      commit_castle_intention(king, rook)
    end

    def queen_side_castling_intention(team)
      king = @pieces[team].king

      empty_road = queen_side_castling_cells_free?(team)
      rook = @pieces[team].rooks.select(&:queen_side?).last

      return CANT_CASTLING unless empty_road && king.can_castling? && rook.can_castling?

      commit_castle_intention(king, rook)
    end
  end
end
