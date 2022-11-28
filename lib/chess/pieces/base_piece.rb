require_relative '../core/chess'
require_relative '../functional/operations'
require_relative '../functional/to_string'
require 'byebug'

module Chess
  class BasePiece
    include Operation
    include ToString

    attr_reader :symbol, :team, :current_step

    Vector = Struct.new(:enabled, :deltas)

    def initialize(symbol, team, cell=nil, cells=nil, captured = false)
      @current_cell = cell
      @cells_history = []
      @cells = cells
      @symbol = symbol
      @captured = captured
      @team = team
      @graph = nil
    end

    def move_to(target_cell)
      return unless can_move_to?(target_cell)

      update_occupied_cell_to(target_cell)
    end

    def can_move_to?(target_cell)
      return false if target_cell.team == @team
      return evaluate_with_one_move(target_cell) if can_move_once_at_tyme?

      evaluate_with_path(target_cell)
    end

    def update_occupied_cell_to(target_cell)
      @cells_history << @current_cell
      @current_cell.free
      target_cell.occupy_with(self)

      @current_cell = target_cell
    end

    def roll_back_step
      @current_step = @current_step.prev_step
      @captured = false

      return unless @first_move == false

      @first_move = true
    end

    def captured?
      @captured
    end

    private

    def enemies_team
      return WHITE_TEAM if @team == BLACK_TEAM
      return BLACK_TEAM if @team == WHITE_TEAM
    end

    def can_move_once_at_tyme?
      %i[P N K].include?(@symbol)
    end

    def evaluate_with_one_move(target_cell)
      @generated_deltas.each do |delta|
        base_cell_coordinates = @current_cell.coordinates.to_a

        base_cell_coordinates = sum_arrays(base_cell_coordinates, delta)
        checked_cell = cells[base_cell_coordinates[0]][base_cell_coordinates[1]]

        reached = checked_cell == target_cell
        break if reached
      end

      reached
    end

    def evaluate_with_path(target_cell)
      @generated_deltas.each do |delta|
        base_cell_coordinates = @current_cell.coordinates.to_a
        keep_tracking = true

        while keep_tracking

          base_cell_coordinates = sum_arrays(base_cell_coordinates, delta)
          checked_cell = cells[base_cell_coordinates[0]][base_cell_coordinates[1]]

          reached = checked_cell == target_cell
          break if reached || checked_cell.occupied?
        end

        break if reached
      end

      reached
    end
  end
end
