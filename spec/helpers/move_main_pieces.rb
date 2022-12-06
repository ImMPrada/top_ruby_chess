# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/ModuleLength
module Helpers
  module MoveMainPieces
    def hardcode_pieces_case1(board)
      white_pieces(:case1, board)
      black_pieces(board)
    end

    def hardcode_pieces_case2(board)
      white_pieces(:case2, board)
      black_pieces(board)
    end

    def hardcode_pieces_case3(board)
      white_pieces(:case3, board)
      black_pieces(board)
    end

    def hardcode_pieces_case4(board)
      white_pieces(:case4, board)
      black_pieces(board)
    end

    def hardcode_pieces_case5(board)
      white_pieces(:case5, board)
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
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5))
          ]
        )
        board.pieces.white.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 4))
          ]
        )
      when :case3
        basic_white_king(board)
        board.pieces.white.instance_variable_set(
          :@pawns,
          [
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 3)),
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 5))
          ]
        )
        board.pieces.white.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(2, 4))
          ]
        )
        board.pieces.black.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(2, 7))
          ]
        )
      when :case4
        basic_white_king(board)
        basic_white_pawns(board)
        board.pieces.white.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(0, 0)),
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(0, 7))
          ]
        )
      when :case5
        basic_white_king(board)
        board.pieces.white.instance_variable_set(
          :@pawns,
          [
            Chess::Core::Pieces::Pawn.create_and_occupy(Chess::WHITE_TEAM, board.cells.dig(1, 4))
          ]
        )
        board.pieces.white.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(0, 0)),
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(0, 7))
          ]
        )
        board.pieces.black.instance_variable_set(
          :@rooks,
          [
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(7, 2)),
            Chess::Core::Pieces::Rook.create_and_occupy(Chess::BLACK_TEAM, board.cells.dig(7, 6))
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
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
