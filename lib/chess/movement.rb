require_relative 'chess'

module Chess
  class Movement
    attr_reader :king_position_string, :enemies_team

    def initialize(intent, cells, occuped_cells_coordinates_by_teams, pieces, team_filter)
      @cells = cells
      @intent = intent
      @symbol_filter = @intent[:symbol].to_sym
      @pieces = pieces
      @occuped_cells_coordinates_by_teams = occuped_cells_coordinates_by_teams
      @team_filter = team_filter
      @piece_moved = nil
      @piece_captured = nil
      @piece_at_origin_cell = nil
      set_origin_target_and_teams
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

    def commit
      @piece_captured = @target_cell.occupant
      remove_captured_from_pieces if @piece_captured

      @origin_cell.free
      @target_cell.free
      @target_cell.occup_by(@piece_moved)
      @king_position_string = @pieces[@friends_team].king.position.algebraic.to_s

      COMMIT_SUCCESS
    end

    def roll_back
      find_cell(@piece_moved.position.algebraic).free

      @piece_moved.roll_back_step
      find_cell(@piece_moved.position.algebraic).occup_by(@piece_moved)

      return ROLLBACK_SUCCES unless @piece_captured

      find_cell(@piece_captured.position.algebraic).occup_by(@piece_captured)
      add_captured_to_pieces
      @piece_captured = nil
      ROLLBACK_SUCCES
    end

    def update_occuped_cells(occuped_cells_coordinates_by_teams)
      @occuped_cells_coordinates_by_teams = occuped_cells_coordinates_by_teams
    end

    private

    def remove_captured_from_pieces
      case @piece_captured.symbol
      when :Q
        @pieces[@enemies_team].queens.delete(@piece_captured)
      when :B
        @pieces[@enemies_team].bishops.delete(@piece_captured)
      when :P
        @pieces[@enemies_team].pawns.delete(@piece_captured)
      when :N
        @pieces[@enemies_team].knights.delete(@piece_captured)
      when :R
        @pieces[@enemies_team].rooks.delete(@piece_captured)
      end
    end

    def add_captured_to_pieces
      case @piece_captured.symbol
      when :Q
        @pieces[@enemies_team].queens << @piece_captured
      when :B
        @pieces[@enemies_team].bishops << @piece_captured
      when :P
        @pieces[@enemies_team].pawns << @piece_captured
      when :N
        @pieces[@enemies_team].knights << @piece_captured
      when :R
        @pieces[@enemies_team].rooks << @piece_captured
      end
    end

    def set_origin_target_and_teams
      @origin_cell = assign_cell(:origin_cell)
      @target_cell = assign_cell(:target_cell)
      @friends_team = @team_filter
      @enemies_team = ([WHITE_TEAM, BLACK_TEAM] - [@friends_team]).first
    end

    def assign_cell(cell_type)
      splitted_cell_string = @intent[cell_type].split('')
      @cells[splitted_cell_string[0].to_sym][splitted_cell_string[1].to_i - 1]
    end

    def find_cell(algebraic)
      @cells[algebraic.column.to_sym][algebraic.row - 1]
    end
  end
end
