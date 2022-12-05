module Helpers
  module RecordPieces
    def hardcode_record_case1(board)
      white_pieces(:case1, board)
    end

    def white_pieces(case_of_use, board)
      case case_of_use
      when :case1
        basic_white_pawns(board)
      end
    end

    def basic_white_pawns(board)
      board.pieces.white.instance_variable_set(
        :@pawns,
        [
          Chess::Core::Pieces::Pawn.create_and_occupy(Chess::Constants::WHITE_TEAM, board.cells.dig(0, 3)),
          Chess::Core::Pieces::Pawn.create_and_occupy(Chess::Constants::WHITE_TEAM, board.cells.dig(1, 3)),
          Chess::Core::Pieces::Pawn.create_and_occupy(Chess::Constants::WHITE_TEAM, board.cells.dig(1, 5)),
          Chess::Core::Pieces::Pawn.create_and_occupy(Chess::Constants::WHITE_TEAM, board.cells.dig(1, 4))
        ]
      )
    end

    def black_pieces(board)
      board.pieces.black.instance_variable_set(
        :@rooks,
        [Chess::Core::Pieces::Rook.create_and_occupy(Chess::Constants::BLACK_TEAM, board.cells.dig(7, 4))]
      )
    end
  end
end
