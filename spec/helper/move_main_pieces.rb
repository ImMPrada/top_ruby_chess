require 'chess/core/board_pieces'

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def hardcode_pieces_case1(board)
  white_pieces(:case1, board)
  black_pieces(board)
end

def white_pieces(case_of_use, board)
  case case_of_use
  when :case1
    basic_white_king(board)
    basic_white_pawns(board)
  when :case2
    basic_white_king(board)
    board.pieces.white.instance_variable_set(
      :@pawns,
      [
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5))
      ]
    )
  end
end

def basic_white_king(board)
  board.pieces.white.instance_variable_set(
    :@king,
    Chess::Core::Pieces::King.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 4))
  )
end

def basic_white_pawns(board)
  board.pieces.white.instance_variable_set(
    :@pawns,
    [
      Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
      Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
      Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 4)),
      Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5))
    ]
  )
end

def black_pieces(board)
  board.pieces.black.instance_variable_set(
    :@rooks,
    [Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(7, 4))]
  )
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
