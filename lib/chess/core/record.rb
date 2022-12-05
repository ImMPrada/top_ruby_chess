require_relative 'chess'

module Chess
  module Core
    class Record
      attr_reader :history

      CommitRecord = Struct.new(:piece, :origin, :target, :capture, :check, :checkmate, :draw, :castling)

      RoundRecord = Struct.new(:white, :black, :draw)

      def initialize
        @history = [RoundRecord.new(nil, nil, nil)]
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

        @history << RoundRecord.new(nil, nil, nil)
        @history.last
      end

      def last_record_available?
        @history.last[@current_record_team].nil?
      end

      def add_move_record(accomplished_intention, capture)
        piece = accomplished_intention.target_cell.occupant.symbol

        current_record[@current_record_team] = CommitRecord.new(
          piece,
          accomplished_intention.origin_cell.name,
          accomplished_intention.target_cell.name,
          capture,
          nil,
          nil,
          nil,
          nil
        )
      end

      def add_castling_record(castling_type)
        current_record[@current_record_team] = CommitRecord.new(
          nil,
          nil,
          nil,
          nil,
          nil,
          nil,
          nil,
          castling_type
        )
      end
    end
  end
end
