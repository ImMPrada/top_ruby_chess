require 'spec_helper'

RSpec.describe Chess::King do
  describe 'with a king on e5' do
    subject(:king) { described_class.new('e5', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[3, 5], [4, 5]],
        Chess::BLACK_TEAM => [[3, 4], [5, 4]]
      }
    end

    it 'can move to f6' do
      expect(king.move_to('f6', occuped_cells)).not_to be_nil
    end

    it 'can move to d4' do
      expect(king.move_to('d4', occuped_cells)).not_to be_nil
    end

    it 'can move to f4' do
      expect(king.move_to('f4', occuped_cells)).not_to be_nil
    end

    it 'can move to f5' do
      expect(king.move_to('f5', occuped_cells)).not_to be_nil
    end

    it "can't move to e6" do
      expect(king.move_to('e6', occuped_cells)).to be_nil
    end

    it "can't move to d6" do
      expect(king.move_to('d6', occuped_cells)).to be_nil
    end

    it "can't move to g7" do
      expect(king.move_to('g7', occuped_cells)).to be_nil
    end
  end

  describe '#can_make_castling' do
    subject(:king) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'when is first move' do
      it 'returns true' do
        expect(king.can_make_castling?).to be(true)
      end
    end

    describe "when isn't first move" do
      it 'returns false' do
        king.move_to('e2', occuped_cells)
        king.move_to('e1', occuped_cells)
        expect(king.can_make_castling?).to be(false)
      end
    end
  end
end
