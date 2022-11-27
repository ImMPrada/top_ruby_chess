require_relative '../chess'
require_relative '../step'
require 'colorize'
require 'colorized_string'
require 'byebug'

module Chess
  class BasePiece
    attr_reader :symbol, :team, :current_step

    Vector = Struct.new(:enabled, :deltas)

    def initialize(position_algebraic, symbol, team, captured = false)
      @current_step = Step.new(position_algebraic)
      @symbol = symbol
      @captured = captured
      @team = team
    end

    def move_to(position, position_deltas_vectors, occuped_cells = nil)
      coordinates = position.coordinates.to_a

      possible_positions = possible_positions(position_deltas_vectors, occuped_cells)
      return unless possible_positions.include?(coordinates)

      position.add_previous(@current_position)
      @current_position = position

      @current_step.position
    end

    def can_move_to?(target_position_algebraic, position_deltas_vectors, occuped_cells = nil)
      possible_step = Step.new(target_position_algebraic)

      possible_positions = possible_positions(position_deltas_vectors, occuped_cells)
      possible_positions.include?(possible_step.position.coordinates.to_a)
    end

    def roll_back_step
      @current_step = @current_step.prev_step
      @captured = false

      return unless @first_move == false

      @first_move = true
    end

    def position
      @current_step.position
    end

    def captured?
      @captured
    end

    def to_s(piece_string)
      return " #{piece_string} ".light_white if @team == WHITE_TEAM

      " #{piece_string} ".black if @team == BLACK_TEAM
    end

    private

    def enemies_team
      ([WHITE_TEAM, BLACK_TEAM] - [@team]).first
    end

    def change_captured_status
      @captured = true
    end

    def possible_positions(position_deltas_vectors, occuped_cells)
      possible_positions_arr = []

      position_deltas_vectors.each_key do |vector_key|
        possible_positions_arr += position_deltas_vectors[vector_key].deltas.map do |delta|
          next unless position_deltas_vectors[vector_key].enabled

          possible_move(@current_step.position.coordinates.to_a,
                        delta, occuped_cells,
                        position_deltas_vectors[vector_key])
        end

        position_deltas_vectors[vector_key].enabled = true
      end

      possible_positions_arr.compact
    end

    def possible_move(position_coordinates_array, delta, occuped_cells, position_deltas_vectors)
      move_to = [position_coordinates_array[0] + delta[0], position_coordinates_array[1] + delta[1]]

      return nil if out_of_board?(move_to)
      return nil unless position_deltas_vectors.enabled

      check_enemies_constraints(move_to, occuped_cells[@enemies_team], position_deltas_vectors)
      check_friends_constraints(move_to, occuped_cells[@team], position_deltas_vectors)
    end

    def check_enemies_constraints(move_to, occuped_cells_by_enemies, position_deltas_vectors)
      position_deltas_vectors.enabled = false if occuped_cells_by_enemies.include?(move_to)

      move_to
    end

    def check_friends_constraints(move_to, occuped_cells_by_friends, position_deltas_vectors)
      if occuped_cells_by_friends.include?(move_to)
        position_deltas_vectors.enabled = false
        return nil
      end

      move_to
    end

    def out_of_board?(move_to)
      move_to[0] < MIN_INDEX || move_to[0] > MAX_INDEX || move_to[1] < MIN_INDEX || move_to[1] > MAX_INDEX
    end

    def enemies_team
      return WHITE_TEAM if @team == BLACK_TEAM

      BLACK_TEAM
    end
  end
end
