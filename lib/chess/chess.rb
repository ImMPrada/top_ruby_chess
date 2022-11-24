module Chess
  MIN_INDEX = 0
  MAX_INDEX = 7
  BLACK_TEAM = :black
  WHITE_TEAM = :white
  QUEEN_SIDE = :queen
  KING_SIDE = :king

  ERR_KING_WILL_DIE = :king_will_die
  ERR_EMPTY_ORIGIN_CELL = :empty_cell
  ERR_WRONG_PIECE_AT_CELL = :wrong_piece
  ERR_CANT_REACH_TARGET_CELL = :null_move
  ERR_CELL_OCCUPED_BY_ENEMY = :cell_of_enemy
  ERR_CANT_CASTLING = :cant_castling
  ERR_INTENTION_PARAMETERS = :error_intention_params

  COMMIT_SUCCESS = :commit_success
  SUBMIT_SUCCESS = :submit_success
  ROLLBACK_SUCCES = :rollback_succes

  ERR_WRONG_INPUT = :wrong_prompt
  CASE_MOVE = :make_move
  CASE_MOVE = :move_prompt
  CASE_CASTLE = :castle_prompt

  RUNNING = :game_running

  COLUMNS = %w[a b c d e f g h].freeze
end
