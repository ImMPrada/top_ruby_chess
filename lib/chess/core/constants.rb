module Chess
  module Core
    module Constants
      MIN_INDEX = 0
      MAX_INDEX = 7
      BLACK_TEAM = :black
      WHITE_TEAM = :white
      QUEEN_SIDE = :queen
      KING_SIDE = :king

      ERR_EMPTY_ORIGIN_CELL = :empty_cell
      ERR_CELL_OCCUPED_BY_ENEMY = :cell_of_enemy
      ERR_CANT_CASTLING = :cant_castling

      COMMIT_SUCCESS = :commit_success
      ROLLBACK_SUCCES = :rollback_succes

      INTENTION_IS_MOVE = :move
      INTENTION_IS_KING_CASTLING = :castling_king_side
      INTENTION_IS_QUEEN_CASTLING = :castling_queen_side

      QUEEN_SIDE_CASTLING_CODE = 'o-o-o'.freeze
      KING_SIDE_CASTLING_CODE = 'o-o'.freeze
      EXIT_COMMAD = :exit_game
      SHOW_RECORD_COMMAD = :show_record

      GAME_RUNNING = :running

      COLUMNS = %w[a b c d e f g h].freeze
      PIECE_STRING = {
        P: "\u265f",
        R: "\u265c",
        N: "\u265e",
        B: "\u265d",
        Q: "\u265b",
        K: "\u265a"
      }.freeze
    end
  end
end
