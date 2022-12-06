require_relative '../constants'
require_relative '../../functional/operations'

module Chess
  module Core
    module Pieces
      class BasePiece
        include Functional::Operations
        include Chess::Constants

        attr_reader :symbol, :team, :current_cell

        Vector = Struct.new(:enabled, :deltas)

        def self.create_and_occupy(symbol, team, current_cell)
          piece = new(symbol, team, current_cell)
          piece.current_cell.occupy_with(piece)

          piece
        end

        def initialize(symbol, team, current_cell)
          @current_cell = current_cell
          @cells_history = []
          @symbol = symbol
          @captured = false
          @team = team
          @graph = nil
        end

        def move_to(target_cell, cells)
          return unless can_move_to?(target_cell, cells)

          update_current_cell_to(target_cell)
        end

        def can_move_to?(target_cell, cells)
          return false if target_cell.team == @team
          return evaluate_with_one_move(target_cell, cells, move_deltas) if can_move_only_once_at_time?

          evaluate_with_path(target_cell, cells, move_deltas)
        end

        def update_current_cell_to(target_cell)
          @cells_history << @current_cell
          @current_cell.release
          target_cell.occupy_with(self)

          @current_cell = target_cell
        end

        def roll_back_cell
          return if @cells_history.empty?

          back_cell = @cells_history.pop
          @current_cell.release
          back_cell.occupy_with(self)

          @current_cell = back_cell
        end

        def back_to_board
          @captured = false
          @current_cell.occupy_with(self)
        end

        def captured?
          @captured
        end

        def become_captured
          @captured = true
        end

        def enemies_team
          return WHITE_TEAM if @team == BLACK_TEAM
          return BLACK_TEAM if @team == WHITE_TEAM
        end

        private

        def evaluate_with_one_move(target_cell, cells, deltas)
          deltas.any? do |delta|
            base_cell_cartesian = @current_cell.cartesian.to_a

            base_cell_cartesian = sum_arrays(base_cell_cartesian, delta)
            next if base_cell_cartesian.any? { |i| i < MIN_INDEX || i > MAX_INDEX }

            checked_cell = cells.dig(base_cell_cartesian[0], base_cell_cartesian[1])
            next if checked_cell.nil?

            checked_cell == target_cell
          end
        end

        def evaluate_with_path(target_cell, cells, deltas)
          deltas.any? do |delta|
            reached_in_path?(@current_cell.cartesian.to_a, delta, cells, target_cell)
          end
        end

        def reached_in_path?(base_cell_cartesian, delta, cells, target_cell)
          reached = false

          until reached
            base_cell_cartesian = sum_arrays(base_cell_cartesian, delta)
            break if base_cell_cartesian.any? { |i| i < MIN_INDEX || i > MAX_INDEX }

            checked_cell = cells.dig(base_cell_cartesian[0], base_cell_cartesian[1])
            reached = checked_cell == target_cell

            break if checked_cell.nil? || checked_cell.occupied?
          end

          reached
        end
      end
    end
  end
end
