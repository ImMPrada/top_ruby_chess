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

      MOVE_INTENTION = :move
      KING_CASTLING_INTENTION = :castling_king_side
      QUEEN_CASTLING_INTENTION = :castling_queen_side

      COLUMNS = %w[a b c d e f g h].freeze
    end
  end
end
