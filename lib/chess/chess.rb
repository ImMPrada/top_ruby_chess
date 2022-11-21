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
  ERR_CAN_REACH_TARGET_CELL = :null_movement
  COMMIT_SUCCESS = :success

  MOVEMENT_RESULTS_MESSAGES = {
    king_will_die: "Cant't move to target cell, the king will die",
    empty_cell: 'Origin cell is empty',
    wrong_piece: 'Origin cell has another piece',

    success: 'movement succesfully commited'
  }.freeze

  COLUMNS = %w[a b c d e f g h].freeze
end
