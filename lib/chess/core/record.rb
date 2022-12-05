require_relative 'chess'

module Chess
  module Core
    class Record
      attr_reader :history

      CommitRecord = Struct.new(:piece, :origin, :target, :piece_captured, :check, :checkmate, :draw, :castling)

      RoundRecord = Struct.new(:white, :black, :draw)

      def initialize
        @history = [RoundRecord.new(nil, nil, nil)]
        @current_record_team = nil
      end

      def add(accomplished_intention, playing_team, capture); end

      private

      def current_record
        return @history.last if last_record_available?

        @history << RoundRecord.new(nil, nil, nil)
        @history.last
      end

      def last_record_available?
        @history.last[@current_record_team].nil?
      end
    end
  end
end
