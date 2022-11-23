require_relative '../chess'
require_relative 'submit_services'
require_relative 'commit_services'
require_relative 'rollback_services'
require 'byebug'

module Chess
  class Movement
    include SubmitServices
    include CommitServices
    include RollbackServices

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
