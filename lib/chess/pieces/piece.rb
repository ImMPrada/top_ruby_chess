require_relative '../chess'
require_relative '../step'
require 'byebug'

module Chess
  class Piece
    CAPTURE_REGEX = 'x'.freeze

    def initialize(position_algebraic, symbol, team, captured = false)
      @current_step = Step.new(position_algebraic)
      @symbol = symbol
      @captured = captured
      @team = team
    end

    def move_to(target_position_algebraic, position_deltas)
      possible_step = Step.new(target_position_algebraic)

      return unless possible_positions(position_deltas).include?(possible_step.position.coordinates.to_a)

      possible_step.add_previous_step(@current_step)
      @current_step = possible_step

      @current_step.position
    end

    private

    def change_captured_status
      @captured = true
    end

    def possible_positions(position_deltas)
      position_deltas.map { |delta| possible_move(@current_step.position.coordinates.to_a, delta) }.compact
    end

    def possible_move(position_coordinates_array, delta)
      move_to = [position_coordinates_array[0] + delta[0], position_coordinates_array[1] + delta[1]]

      return nil if move_to[0] < MIN_INDEX || move_to[0] > MAX_INDEX
      return nil if move_to[1] < MIN_INDEX || move_to[1] > MAX_INDEX

      move_to
    end
  end
end
