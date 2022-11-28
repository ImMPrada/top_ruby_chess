require 'colorize'
require 'colorized_string'

module Chess
  module ToString
    def to_s
      return piece_string if self.class.superclass == Chess::BasePiece
    end

    private

    def piece_string
      return " #{text_symbol} ".light_white if @team == WHITE_TEAM

      " #{text_symbol} ".black if @team == BLACK_TEAM
    end
  end
end
