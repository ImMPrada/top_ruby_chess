require_relative '../chess'

module Chess
  module SubmitServices
    def castle_submit(rook)
      set_origin_target_and_teams
      @piece_at_origin_cell = @origin_cell.occupant

      return ERR_CELL_OCCUPED_BY_ENEMY unless @piece_at_origin_cell.team == @team_filter
      return ERR_EMPTY_ORIGIN_CELL unless @piece_at_origin_cell
      return ERR_WRONG_PIECE_AT_CELL unless @piece_at_origin_cell.symbol == @symbol_filter

      position_reached = @piece_at_origin_cell.castle_with(rook, @occuped_cells_coordinates_by_teams, rook.side)
      return ERR_CANT_CASTLING unless position_reached

      @piece_moved = [@piece_at_origin_cell, rook]
      SUBMIT_SUCCESS
    end

    def submit
      set_origin_target_and_teams
      @piece_at_origin_cell = @origin_cell.occupant

      return ERR_CELL_OCCUPED_BY_ENEMY unless @piece_at_origin_cell.team == @team_filter
      return ERR_EMPTY_ORIGIN_CELL unless @piece_at_origin_cell
      return ERR_WRONG_PIECE_AT_CELL unless @piece_at_origin_cell.symbol == @symbol_filter

      position_reached = @piece_at_origin_cell.move_to(@target_cell.algebraic.to_s,
                                                       @occuped_cells_coordinates_by_teams,
                                                       @target_cell.occuped?)
      return ERR_CAN_REACH_TARGET_CELL unless position_reached

      @piece_moved = @piece_at_origin_cell
      SUBMIT_SUCCESS
    end
  end
end
