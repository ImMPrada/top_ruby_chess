require_relative 'chess'

module Chess
  class Record
    attr_reader :history

    CommitRecord = Struct.new(:piece, :origin, :target, :piece_captured, :check, :checkmate, :draw, :castling) do
      def to_s
        return KING_SIDE_CASTLING_CODE if castling == KING_SIDE
        return QUEEN_SIDE_CASTLING_CODE if castling == QUEEN_SIDE

        "#{piece.upcase}#{origin}#{'x' if piece_captured}#{target}#{"\u2020" if check}#{"\u2021" if checkmate}"
      end
    end

    RoundRecord = Struct.new(:white, :black, :draw) do
      def to_s
        return '(=)' if draw

        "#{white}   #{black}"
      end
    end

    def initialize
      @history = [RoundRecord.new(nil, nil, nil)]
      @current_record_team = nil
    end

    def add_move(move)
      @current_record_team = move.team_filter
      empty_record = current_record
      move_intention = move.intention
      
      piece_symbol = move_intention[:symbol_filter].upcase
      
      byebug
      empty_record[@current_record_team] = CommitRecord.new(piece_symbol,
                                                            move_intention[:origin_cell],
                                                            move_intention[:target_cell],
                                                            move.piece_captured,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil)

      COMMIT_SUCCESS
    end

    def add_castling(rook)
      @current_record_team = rok.team
      empty_record = current_record
      castling_side = rook.side

      empty_record[@current_record_team] = CommitRecord.new(nil, nil, nil, nil, nil, nil, nil, castling_side)

      COMMIT_SUCCESS
    end

    private

    def current_record
      return @history.last if last_record_available?

      @history << RoundRecord.new(nil, nil, nil)
      byebug
      @history.last
    end

    def last_record_available?
      @history.last[@current_record_team].nil?
    end
  end
end
