require_relative '../chess'
require_relative 'piece'
require 'byebug'

module Chess
  class King < Piece
    SYMBOL = :K

    def initialize(coordinates, team)
      super(coordinates, SYMBOL, team)
      @generated_deltas = {
        v1: Vector.new(true, []),
        v2: Vector.new(true, []),
        v3: Vector.new(true, []),
        v4: Vector.new(true, []),
        v5: Vector.new(true, []),
        v6: Vector.new(true, []),
        v7: Vector.new(true, []),
        v8: Vector.new(true, [])
      }
      @capture_movements = nil
      @first_move = true

      generate_deltas
    end

    def move_to(position_algebraic, occuped_cells, capturing = false)
      super_response = super(position_algebraic, capturing ? @capture_movements : @generated_deltas, occuped_cells)
      return unless super_response

      @first_move = false
      super_response
    end

    def castle_with(piece, occuped_cells, castling_side)
      return unless can_castling? && piece.can_castling?

      return unless can_castle_at?(castling_side, occuped_cells[BLACK_TEAM] + occuped_cells[WHITE_TEAM])

      original_generated_deltas = @generated_deltas
      @generated_deltas = {
        v1: Vector.new(true, [[2, 0]]),
        v2: Vector.new(true, [[-2, 0]])
      }

      move_to(target_castling_position_king(castling_side), occuped_cells)
      @generated_deltas = original_generated_deltas
      piece.move_to(target_castling_position_rook(castling_side), occuped_cells)
    end

    def can_castling?
      @first_move
    end

    def can_attack_to?(target_position_algebraic, occuped_cells)
      can_move_to?(target_position_algebraic, @capture_movements, occuped_cells)
    end

    def to_s
      super("\u265a")
    end

    private

    def target_castling_position_rook(castling_side)
      algebraic_row = position.algebraic.row

      case castling_side
      when QUEEN_SIDE
        "d#{algebraic_row}"
      when KING_SIDE
        "f#{algebraic_row}"
      end
    end

    def target_castling_position_king(castling_side)
      algebraic_row = position.algebraic.row

      case castling_side
      when QUEEN_SIDE
        "c#{algebraic_row}"
      when KING_SIDE
        "g#{algebraic_row}"
      end
    end

    def can_castle_at?(castling_side, occuped_cells)
      case castling_side
      when QUEEN_SIDE
        queen_side_cells.none? { |cell| occuped_cells.include?(cell) }
      when KING_SIDE
        king_side_cells.none? { |cell| occuped_cells.include?(cell) }
      end
    end

    def queen_side_cells
      row = position.coordinates.row
      [[1, row], [2, row], [3, row]]
    end

    def king_side_cells
      row = position.coordinates.row
      [[5, row], [6, row]]
    end

    # rubocop:disable Metrics/AbcSize
    def generate_deltas
      @generated_deltas[:v1].deltas << [0, 1]
      @generated_deltas[:v2].deltas << [1, 1]
      @generated_deltas[:v3].deltas << [1, 0]
      @generated_deltas[:v4].deltas << [1, -1]
      @generated_deltas[:v5].deltas << [0, -1]
      @generated_deltas[:v6].deltas << [-1, -1]
      @generated_deltas[:v7].deltas << [-1, 0]
      @generated_deltas[:v8].deltas << [-1, 1]

      @capture_movements = @generated_deltas
    end
    # rubocop:enable Metrics/AbcSize
  end
end
