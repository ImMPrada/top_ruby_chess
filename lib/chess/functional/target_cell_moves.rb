require_relative 'operations'

module Chess
  module Functional
    module TargetCellMove
      include Operations

      def can_any_piece_move_to?(cell, cells, pieces)
        pieces.any? { |piece| piece.can_move_to?(cell, cells) }
      end

      def checkmate?(check_pice, king_in_check, all_pieces)
        return false if can_any_piece_move_to?(check_pice.current_cell, cells, all_pieces[team_in_check].all)
        return false if king_can_scape?(king_in_check, cells, all_pieces[king_in_check.enemy_team].all)
        return false if can_any_friend_intersect_path?(check_pice, king_in_check, all_pieces[king_in_check.team].all)

        true
      end

      private

      def king_can_scape?(king_in_check, cells, enemy_pieces)
        king_in_check.current_cell.neighbors(cells).any? do |cell|
          cell.empty? && !can_any_piece_move_to?(cell, cells, enemy_pieces)
        end
      end

      # rubocop:disable Metrics/AbcSize
      def can_any_friend_intersect_path?(check_pice, king_in_check, all_friend_pieces, cells)
        response = false
        delta = directive_of(check_pice.current_cell.cartesian.to_a, king_in_check.current_cell.cartesian.to_a)

        current_cell = cells.dig(*sum_arrays(current_cell.cartesian.to_a, delta))

        until current_cell == king_in_check.current_cell
          response = can_any_piece_move_to?(current_cell, cells, all_friend_pieces)
          break if response

          current_cell = cells.dig(*sum_arrays(current_cell.cartesian.to_a, delta))
        end

        response
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end

[cell2_row, cell2_column] - [cell1_row, cell1_column]
