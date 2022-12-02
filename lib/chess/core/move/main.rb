require_relative '../chess'
require_relative 'submit_services'
require_relative 'commit_services'
require_relative 'rollback_services'

module Chess
  module Core
    module Move
      class Main
        include SubmitServices
        include CommitServices
        include RollbackServices

        attr_reader :king_position_string, :enemies_team, :piece_captured, :intention, :team_filter

        def initialize(intention, board, team_filter)
          @intention = intention
          @cells = board.cells
          @pieces = board.pieces
          @symbol_filter = @intention[:symbol_filter].to_sym

          @team_filter = team_filter
          @piece_moved = nil
          @piece_captured = nil
        end
      end
    end
  end
end
