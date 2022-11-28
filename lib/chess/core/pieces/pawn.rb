require_relative 'base_piece'

module Chess
  module Core
    module Pieces
      class Pawn < BasePiece
        SYMBOL = :P
        TEXT = "\u265f".freeze

        def initialize(team, cell)
          super(SYMBOL, team, cell)
          @first_move = true
          @capturing = false
        end

        def move_to(target_cell, cells)
          @capturing = true if target_cell.team == enemies_team
          generate_deltas

          super_response = super(target_cell, cells)
          return unless super_response

          @first_move = false
          @capturing = false
          super_response
        end

        def can_move_to?(target_cell, cells)
          @capturing = true if target_cell.team == enemies_team
          generate_deltas

          super(target_cell, cells)
        end

        private

        def text
          TEXT
        end

        def generate_deltas
          @generated_deltas = []
          return generate_white_deltas if @team == WHITE_TEAM
          return generate_black_deltas if @team == BLACK_TEAM
        end

        def generate_white_deltas
          if @capturing
            @generated_deltas << [1, 1]
            @generated_deltas << [1, -1]
          else
            @generated_deltas << [1, 0]
          end

          return unless @first_move

          @generated_deltas << [2, 0] unless @capturing
        end

        def generate_black_deltas
          if @capturing
            @generated_deltas << [-1, 1]
            @generated_deltas << [-1, -1]
          else
            @generated_deltas << [-1, 0]
          end

          return unless @first_move

          @generated_deltas << [-2, 0] unless @capturing
        end
      end
    end
  end
end
