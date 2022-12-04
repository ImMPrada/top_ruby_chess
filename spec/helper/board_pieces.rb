# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def hardcode_pieces_checkmate_case1(board)
  board.instance_variable_set(
    :@pieces,
    {
      Chess::WHITE_TEAM => white_pieces(:case1, board),
      Chess::BLACK_TEAM => black_pieces(board)
    }
  )
end

def hardcode_pieces_checkmate_case2(board)
  board.instance_variable_set(
    :@pieces,
    {
      Chess::WHITE_TEAM => white_pieces(:case2, board),
      Chess::BLACK_TEAM => black_pieces(board)
    }
  )
end

def hardcode_pieces_checkmate_case3(board)
  board.instance_variable_set(
    :@pieces,
    {
      Chess::WHITE_TEAM => white_pieces(:case3, board),
      Chess::BLACK_TEAM => black_pieces(board)
    }
  )
end

def hardcode_pieces_checkmate_case4(board)
  board.instance_variable_set(
    :@pieces,
    {
      Chess::WHITE_TEAM => white_pieces(:case4, board),
      Chess::BLACK_TEAM => black_pieces(board)
    }
  )
end

def white_pieces(case_of_use, board)
  case case_of_use
  when :case1
    Chess::Core::Board::Pieces.new(
      Chess::Core::Pieces::King.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 4)),
      [],
      [],
      [],
      [],
      [
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 5))
      ]
    )
  when :case2
    Chess::Core::Board::Pieces.new(
      Chess::Core::Pieces::King.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 4)),
      [],
      [],
      [],
      [],
      [
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5))
      ]
    )
  when :case3
    Chess::Core::Board::Pieces.new(
      Chess::Core::Pieces::King.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 4)),
      [],
      [
        Chess::Core::Pieces::Bishop.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(3, 0))
      ],
      [],
      [],
      [
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 5))
      ]
    )
  when :case4
    Chess::Core::Board::Pieces.new(
      Chess::Core::Pieces::King.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 4)),
      [],
      [],
      [],
      [
        Chess::Core::Pieces::Rook.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(3, 0))
      ],
      [
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5)),
        Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(0, 5))
      ]
    )
  end
end

def black_pieces(board)
  Chess::Core::Board::Pieces.new(
    nil,
    [],
    [],
    [],
    [
      Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(7, 4))
    ],
    []
  )
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
