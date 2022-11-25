require 'spec_helper'

RSpec.describe Chess::Pawn do
  describe 'with a pawn on e2' do
    subject(:pawn) { described_class.new('e2', Chess::WHITE_TEAM) }

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

      it "can't move from e4 to e6 before first move" do
        pawn.move_to('e4', occuped_cells)
        expect(pawn.move_to('e6', occuped_cells)).to be_nil
      end
    end

    describe 'when there ara enemies' do
      let(:occuped_cells) do
        {
          Chess::WHITE_TEAM => [],
          Chess::BLACK_TEAM => [[5, 3], [6, 2]]
        }
      end

      it "can't capture enemy at e4, if isn't first move" do
        pawn.move_to('e3', occuped_cells)
        expect(pawn.move_to('e4', occuped_cells, true)).to be_nil
      end

      it 'can capture enemy at f3, at first move' do
        expect(pawn.move_to('f3', occuped_cells, true)).not_to be_nil
      end
    end
  end

  describe '#can_attack_to?' do
    subject(:pawn) { described_class.new('e2', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[5, 0]],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'whit a pawn at e2' do
      it 'can attack on f3' do
        expect(pawn.can_attack_to?('f3', occuped_cells)).to be(true)
      end

      it "can't attack on e3" do
        expect(pawn.can_attack_to?('e3', occuped_cells)).to be(false)
      end
    end
  end
end
