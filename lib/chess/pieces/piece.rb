require_relative '../chess'
require_relative '../step'
require 'byebug'

module Chess
  class Piece
    CAPTURE_REGEX = 'x'.freeze

    attr_reader :symbol, :team

    Vector = Struct.new(:enable, :deltas)

    def initialize(position_algebraic, symbol, team, captured = false)
      @current_step = Step.new(position_algebraic)
      @symbol = symbol
      @captured = captured
      @team = team
      @enemies_team = ([WHITE_TEAM, BLACK_TEAM] - [@team]).first
    end

    def move_to(target_position_algebraic, position_deltas_vectors, occuped_cells = nil)
      possible_step = Step.new(target_position_algebraic)

      possible_positions = possible_positions(position_deltas_vectors, occuped_cells)
      return unless possible_positions.include?(possible_step.position.coordinates.to_a)

      possible_step.add_previous_step(@current_step)
      @current_step = possible_step

      @current_step.position
    end

    def can_move_to?(target_position_algebraic, position_deltas_vectors, occuped_cells = nil)
      possible_step = Step.new(target_position_algebraic)

      possible_positions = possible_positions(position_deltas_vectors, occuped_cells)
      possible_positions.include?(possible_step.position.coordinates.to_a)
    end

    def position
      @current_step.position
    end

    def captured?
      @captured
    end

    private

    def change_captured_status
      @captured = true
    end

    def possible_positions(position_deltas_vectors, occuped_cells)
      possible_positions_arr = []

      position_deltas_vectors.each_key do |vector_key|
        possible_positions_arr += position_deltas_vectors[vector_key].deltas.map do |delta|
          next unless position_deltas_vectors[vector_key].enable

          possible_move(@current_step.position.coordinates.to_a,
                        delta, occuped_cells,
                        position_deltas_vectors[vector_key])
        end

        position_deltas_vectors[vector_key].enable = true
      end

      possible_positions_arr.compact
    end

    def possible_move(position_coordinates_array, delta, occuped_cells, position_deltas_vectors)
      move_to = [position_coordinates_array[0] + delta[0], position_coordinates_array[1] + delta[1]]

      return nil if out_of_board?(move_to)
      return nil unless position_deltas_vectors.enable

      check_enemies_constraints(move_to, occuped_cells[@enemies_team], position_deltas_vectors)
      check_friends_constraints(move_to, occuped_cells[@team], position_deltas_vectors)
    end

    def check_enemies_constraints(move_to, occuped_cells_by_enemies, position_deltas_vectors)
      position_deltas_vectors.enable = false if occuped_cells_by_enemies.include?(move_to)

      move_to
    end

    def check_friends_constraints(move_to, occuped_cells_by_friends, position_deltas_vectors)
      if occuped_cells_by_friends.include?(move_to)
        position_deltas_vectors.enable = false
        return nil
      end

      move_to
    end

    def out_of_board?(move_to)
      move_to[0] < MIN_INDEX || move_to[0] > MAX_INDEX || move_to[1] < MIN_INDEX || move_to[1] > MAX_INDEX
    end
  end
end
