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
  ERR_CANT_REACH_TARGET_CELL = :null_movement
  ERR_CELL_OCCUPED_BY_ENEMY = :cell_of_enemy
  COMMIT_SUCCESS = :commit_success
  SUBMIT_SUCCESS = :submit_success
  ROLLBACK_SUCCES = :rollback_succes

  CASE_MOVEMENT = :make_movement

  RUNNING = :game_running
  ERR_WRONG_INPUT = :wrong_prompt

  CASE_MOVEMENT = :movement_prompt
  CASE_CASTLE = :castle_prompt

  CANT_CASTLING = :cant_castling

  ERR_INTENTION_PARAMETERS = :error_intention_params

  MOVEMENT_RESULTS_MESSAGES = {
    king_will_die: "Cant't move to target cell, the king will die",
    empty_cell: 'Origin cell is empty',
    wrong_piece: 'Origin cell has another piece',

    success: 'movement succesfully commited'
  }.freeze

  COLUMNS = %w[a b c d e f g h].freeze
end
