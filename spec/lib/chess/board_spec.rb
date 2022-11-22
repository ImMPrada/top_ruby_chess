require 'spec_helper'

RSpec.describe Chess::Board do
  subject(:board) { described_class.new }

  describe '#movement_intention' do
    describe 'when move a piece, expose the king to death' do
      before do
        puts board
        board.movement_intention(:P, 'a2', 'a4', Chess::WHITE_TEAM)
        puts board
        board.movement_intention(:P, 'e7', 'e6', Chess::BLACK_TEAM)
        puts board
        board.movement_intention(:N, 'g1', 'h3', Chess::WHITE_TEAM)
        puts board
        board.movement_intention(:Q, 'd8', 'h4', Chess::BLACK_TEAM)
        puts board
      end

      it 'rollbacks the commitment' do
        expect(board.movement_intention(:P, 'f2', 'f4', Chess::WHITE_TEAM)).to be(Chess::ROLLBACK_SUCCES)
      end
    end
  end
end
