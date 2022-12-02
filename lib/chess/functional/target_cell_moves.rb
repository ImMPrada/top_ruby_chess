require_relative 'operations'

module Chess
  module Functional
    module TargetCellMoves
      include Operations

      def can_any_piece_move_to?(cell, cells, pieces)
        return if pieces.nil? || pieces.empty? || cells.nil? || cells.empty?

        pieces.any? { |piece| piece.can_move_to?(cell, cells) }
      end

      # rubocop:disable Metrics/MethodLength
      def checkmate?(check_pice, king_in_check, all_pieces, cells)
        return false if can_any_piece_move_to?(
          check_pice.current_cell,
          cells,
          all_pieces[king_in_check.team].all
        )
        return false if king_can_escape?(
          king_in_check,
          cells,
          all_pieces[king_in_check.enemies_team].all
        )
        return false if can_any_friend_intersect_path?(
          check_pice, king_in_check,
          all_pieces[king_in_check.team].all,
          cells
        )

        true
      end
      # rubocop:enable Metrics/MethodLength

      private

      def king_can_escape?(king_in_check, cells, enemy_pieces)
        king_in_check.neighbors(cells).any? do |cell|
          !cell.occupied? && !can_any_piece_move_to?(cell, cells, enemy_pieces)
        end
      end

      # rubocop:disable Metrics/AbcSize
      def can_any_friend_intersect_path?(check_pice, king_in_check, all_friend_pieces, cells)
        response = false
        delta = directive_of(
          check_pice.current_cell.cartesian.to_a,
          king_in_check.current_cell.cartesian.to_a
        )

        current_cell = cells.dig(*sum_arrays(check_pice.current_cell.cartesian.to_a, delta))

        until current_cell == king_in_check.current_cell
          response = can_any_piece_move_to?(current_cell, cells, all_friend_pieces)
          puts current_cell.name
          break if response

          current_cell = cells.dig(*sum_arrays(current_cell.cartesian.to_a, delta))
        end

        response
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
