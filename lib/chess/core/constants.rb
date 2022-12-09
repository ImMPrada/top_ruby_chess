module Chess
  module Core
    module Constants
      MIN_INDEX = 0
      MAX_INDEX = 7
      BLACK_TEAM = :black
      WHITE_TEAM = :white
      QUEEN_SIDE = :queen
      KING_SIDE = :king

      EMPTY_ORIGIN_CELL_ERROR = :empty_cell
      CELL_OCCUPED_BY_ENEMY_ERROR = :cell_of_enemy
      CANT_CASTLING_ERROR = :cant_castling
      WRONG_INPUT_ERROR = :wrong_input

      COMMIT_SUCCESS = :commit_success
      ROLLBACK_SUCCES = :rollback_succes

      MOVE_INTENTION = :move
      KING_CASTLING_INTENTION = :castling_king_side
      QUEEN_CASTLING_INTENTION = :castling_queen_side

      QUEEN_SIDE_CASTLING_CODE = 'o-o-o'.freeze
      KING_SIDE_CASTLING_CODE = 'o-o'.freeze
      EXIT_COMMAD = :exit_game
      SHOW_RECORD_COMMAD = :show_record

      GAME_RUNNING = :running
      GAME_STOP = :stop
      CASE_CASTLE = :move_is_castle
      CASE_MOVE = :move
      COMMAND_SUCCES = :command_succes

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
