module Chess
  module MovementServices
    def submit_movement(piece_symbol, origin_cell, target_cell)
      splitedd_origin_cell = origin_cell.split('')

      origin_cell = @cells[splitedd_origin_cell[0].to_sym][splitedd_origin_cell[1].to_i - 1]
      piece_at_origin_cell = origin_cell.occupant

      return ERR_EMPTY_ORIGIN_CELL unless piece_at_origin_cell
      return ERR_WRONG_PIECE_AT_CELL unless piece_at_origin_cell.symbol == piece_symbol.to_sym

      piece_moved = piece_at_origin_cell.move_to(target_cell, occuped_cells_coordinates_by_teams)
      return ERR_CAN_REACH_TARGET_CELL unless piece_moved

      piece_at_origin_cell
    end

    def commit_movement(piece_moved)
      temporary_commit(piece_moved)
      return check_for_check_or_checkmate unless can_enemies_take_the_king_right_now?(piece_moved.team)

      roll_back_commitment(piece_moved)
      ERR_KING_WILL_DIE
    end

    private

    def check_for_check_or_checkmate
      COMMIT_SUCCESS
    end

    def roll_back_commitment(piece_moved)
      current_position_algebraic = piece_moved.position.algebraic
      prev_position_algebraic = piece_moved.current_step.prev_step.position.algebraic
      piece_moved.roll_back_step

      free_cell(current_position_algebraic)
      occup_cell(prev_position_algebraic, piece_moved)
    end

    def temporary_commit(piece_moved)
      current_position_algebraic = piece_moved.position.algebraic
      prev_position_algebraic = piece_moved.current_step.prev_step.position.algebraic

      free_cell(prev_position_algebraic)
      occup_cell(current_position_algebraic, piece_moved)
    end

    def can_enemies_take_the_king_right_now?(friends_team)
      enemies_team = ([WHITE_TEAM, BLACK_TEAM] - [friends_team]).first
      king_position = @pieces[friends_team].king.position.algebraic.to_s

      can_any_enemy_attack_to?(king_position, enemies_team)
    end

    def free_cell(cell_position)
      cell_to_free = @cells[cell_position.column.to_sym][cell_position.row - 1]
      cell_to_free.free
    end

    def occup_cell(cell_position, piece_moved)
      cell_to_occup = @cells[cell_position.column.to_sym][cell_position.row - 1]
      cell_to_occup.occup_by(piece_moved)
    end
  end
end
