require_relative 'constants'

module Chess
  module Core
    class Record
      attr_reader :history

      include Chess::Core::Constants

      CommitRecord = Struct.new(
        :piece,
        :origin,
        :target,
        :capture,
        :check,
        :checkmate,
        :draw,
        :castling,
        keyword_init: true
      )

      RoundRecord = Struct.new(:white, :black, :draw, keyword_init: true)

      def initialize
        @history = [RoundRecord.new]
        @current_record_team = nil
      end

      def add(accomplished_intention, playing_team, capture)
        @current_record_team = playing_team
        type = accomplished_intention.type

        return add_move_record(accomplished_intention, capture) if type == INTENTION_IS_MOVE
        return add_castling_record(type) if [INTENTION_IS_KING_CASTLING, INTENTION_IS_QUEEN_CASTLING].include?(type)
      end

      private

      def current_record
        return @history.last if last_record_available?

        @history << RoundRecord.new
        @history.last
      end

      def last_record_available?
        @history.last[@current_record_team].nil?
      end

      def add_move_record(accomplished_intention, capture)
        occupant_symbol = accomplished_intention.target_cell.occupant.symbol

        current_record[@current_record_team] = CommitRecord.new(
          piece: occupant_symbol,
          origin: accomplished_intention.origin_cell.name,
          target: accomplished_intention.target_cell.name,
          capture:
        )
      end

      def add_castling_record(castling_type)
        current_record[@current_record_team] = CommitRecord.new(
          castling: castling_type
        )
      end
    end
  end
end
