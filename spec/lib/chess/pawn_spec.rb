require 'spec_helper'

RSpec.describe Chess::Pawn do
  subject(:pawn) { described_class.new('e2', Chess::WHITE_TEAM) }

  describe 'with a pawn on e2' do
    describe 'when is first move' do
      let(:occuped_cells) do
        {
          Chess::WHITE_TEAM => [],
          Chess::BLACK_TEAM => []
        }
      end

      it 'can move 1 cell straight (to e3)' do
        expect(pawn.move_to('e3', occuped_cells)).not_to be_nil
      end

      it 'can move 2 cells straight (to e4)' do
        expect(pawn.move_to('e4', occuped_cells)).not_to be_nil
      end

      it 'can move from e4 to e5 before first move' do
        pawn.move_to('e4', occuped_cells)
        expect(pawn.move_to('e5', occuped_cells)).not_to be_nil
      end
    end
  end
end
