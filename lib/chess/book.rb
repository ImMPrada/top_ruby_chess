require_relative 'chess'
require_relative './board/board'
require_relative './movement/movement'

module Chess
  class Book
    def initialize(board)
      @board = board
      @cells = board.cells
      @pieces = board.pieces
    end

    def movement_intention(piece_symbol, origin_cell, target_cell, team_filter)
      intention = { symbol: piece_symbol, origin_cell:, target_cell: }
      movement = Movement.new(intention, @cells, @board.occuped_cells_coordinates_by_teams, @pieces, team_filter)

      submit_result = movement.submit
      return submit_result unless submit_result == SUBMIT_SUCCESS

      commit_result = movement.commit
      movement.update_occuped_cells(@board.occuped_cells_coordinates_by_teams)

      if commit_result == COMMIT_SUCCESS
        king_in_risk = @board.can_any_enemy_attack_to?(movement.king_position_string,
                                                       movement.enemies_team,
                                                       @board.occuped_cells_coordinates_by_teams)
      end
      return commit_result unless king_in_risk

      movement.roll_back
    end

    def castle_intention_on(side, team)
      return ERR_INTENTION_PARAMETERS unless [WHITE_TEAM, BLACK_TEAM].include?(team)

      return king_side_castling_intention(team) if side == KING_SIDE
      return queen_side_castling_intention(team) if side == QUEEN_SIDE

      ERR_INTENTION_PARAMETERS
    end

    private

    def commit_castle_intention(king, rook)
      current_cells_occupation = @board.occuped_cells_coordinates_by_teams

      king_movement = setup_king_movement_instance(king, rook, current_cells_occupation)

      king_submit_result = king_movement.castle_submit(rook)
      return king_submit_result unless king_submit_result == SUBMIT_SUCCESS

      commit_result = king_movement.castle_commit
      king_movement.update_occuped_cells(@board.occuped_cells_coordinates_by_teams)

      if commit_result == COMMIT_SUCCESS
        king_in_risk = @board.can_any_enemy_attack_to?(king_movement.king_position_string,
                                                       king_movement.enemies_team,
                                                       @board.occuped_cells_coordinates_by_teams)
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

    def king_side_castling_cells_free?(team)
      return path_empty?(%w[f g], MIN_INDEX + 1) if team == WHITE_TEAM
      return path_empty?(%w[f g], MAX_INDEX + 1) if team == BLACK_TEAM
    end

    def queen_side_castling_cells_free?(team)
      return path_empty?(%w[b c d], MIN_INDEX + 1) if team == WHITE_TEAM
      return path_empty?(%w[b c d], MAX_INDEX + 1) if team == BLACK_TEAM
    end

    def path_empty?(road_columns, row)
      road = road_columns.map do |road_column|
        cell = find_cell("#{road_column}#{row}")
        cell.occuped?
      end
      road.all?(false)
    end

    def find_cell(cell_algebraic_string)
      splitted_cell_string = cell_algebraic_string.split('')
      @cells[splitted_cell_string[0].to_sym][splitted_cell_string[1].to_i - 1]
    end
  end
end
