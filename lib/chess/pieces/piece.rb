require_relative '../chess'
require_relative '../node'
require 'byebug'

module Chess
  class Piece
    CAPTURE_REGEX = 'x'.freeze
    COLUMNS = %w[a b c d e f g h].freeze

    def initialize(coordinates, symbol, team, captured = false)
      @position = Node.new(coordinates)
      @symbol = symbol
      @captured = captured
      @team = team
    end

    def move_to(position, position_deltas)
      new_position_coordinates = transpile_algebraic_notation_to_coordinates(position)

      return unless possible_positions(position_deltas).include?(new_position_coordinates)

      @position = Node.new(new_position_coordinates, @position)
    end

    def capture_piece(piece_to_be_captured)
      piece_to_be_captured.change_capture_status

      captured_symbol = piece_to_be_captured.symbol
      captured_team = piece_to_be_captured.team
      captured_position = piece_to_be_captured.position.coordinates

      message_part1 = "Captured #{captured_symbol}-#{captured_team}! at #{captured_position}"
      message_part2 = "by #{symbol}-#{team}"

      "#{message_part1} #{message_part2}"
    end

    private

    def change_capture_status
      @captured = true
    end

    def possible_positions(position_deltas)
      position_deltas.map { |delta| possible_move(@position.coordinates, delta) }.compact
    end

    def transpile_algebraic_notation_to_coordinates(algebraic_notation)
      algebraic_notation = algebraic_notation.split('')

      column = COLUMNS.index(algebraic_notation[0])
      row = algebraic_notation[1].to_i - 1

      [row, column]
    end

    def possible_move(position, delta)
      move_to = [position[0] + delta[0], position[1] + delta[1]]

      return nil if move_to[0] < MIN_INDEX || move_to[0] > MAX_INDEX
      return nil if move_to[1] < MIN_INDEX || move_to[1] > MAX_INDEX

      move_to
    end
  end
end
