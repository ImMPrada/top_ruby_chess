require_relative '../chess'
# require_relative 'submit_services'
# require_relative 'commit_services'
# require_relative 'rollback_services'
require_relative '../../functional/cell_notation'
require 'byebug'

module Chess
  module Core
    module Move
      class Main
        include SubmitServices
        include CommitServices
        include RollbackServices
        include Chess::Functional::CellNotation

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_playing)
          @intention = intention
          @team_playing = team_playing
          @board = board
          @cells = board.cells
          @pieces = board.pieces
        end

        def run; end
      end
    end
  end
end
