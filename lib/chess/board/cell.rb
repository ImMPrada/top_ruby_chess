require 'colorize'
require 'colorized_string'

require_relative '../chess'
require_relative '../position'

module Chess
  class Cell < Position
    attr_reader :team

    def initialize(algebraic_notation, fill_color, occuped = false, occuped_by = nil, team = nil)
      @occuped = occuped
      @occuped_by = occuped_by
      @team = team
      @fill_color = fill_color

      super(algebraic_notation)
    end

    def occup_by(piece)
      @occuped = true
      @team = piece.team
      @occuped_by = piece
    end

    def free
      @occuped = false
      @team = nil
      @occup_by = nil
    end

    def occupant
      @occuped_by
    end

    def occuped?
      @occuped
    end

    def to_s
      in_cell = '   '
      in_cell = @occuped_by.to_s if occuped?

      return in_cell.on_light_red if @fill_color == WHITE_TEAM

      in_cell.on_red if @fill_color == BLACK_TEAM
    end
  end
end
