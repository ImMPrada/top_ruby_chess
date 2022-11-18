require 'spec_helper'

RSpec.describe Chess::Bishop do
  subject(:bishop) { described_class.new('e5', Chess::WHITE_TEAM) }

  let(:occuped_cells) do
    {
      Chess::WHITE_TEAM => [[4, 3], [4, 6], [7, 7]],
      Chess::BLACK_TEAM => [[0, 4], [2, 6], [5, 4]]
    }
  end

  describe 'with a bishop on e5' do
    it 'can move to c7' do
      expect(bishop.move_to('c7', occuped_cells)).not_to be_nil
    end

    it 'can move to g7' do
      expect(bishop.move_to('g7', occuped_cells)).not_to be_nil
    end

    it 'can move to g3' do
      expect(bishop.move_to('g3', occuped_cells)).not_to be_nil
    end

    it 'can move to a1' do
      expect(bishop.move_to('a1', occuped_cells)).not_to be_nil
    end

    it 'can move to c3' do
      expect(bishop.move_to('c3', occuped_cells)).not_to be_nil
    end

    it "can't move to e6" do
      expect(bishop.move_to('e6', occuped_cells)).to be_nil
    end

    it "can't move to e7" do
      expect(bishop.move_to('e7', occuped_cells)).to be_nil
    end

    it "can't move to b8" do
      expect(bishop.move_to('b8', occuped_cells)).to be_nil
    end

    it "can't move to d5" do
      expect(bishop.move_to('d5', occuped_cells)).to be_nil
    end

    it "can't move to b5" do
      expect(bishop.move_to('b5', occuped_cells)).to be_nil
    end

    it "can't move to a5" do
      expect(bishop.move_to('a5', occuped_cells)).to be_nil
    end

    it "can't move to a3" do
      expect(bishop.move_to('a3', occuped_cells)).to be_nil
    end

    it "can't move to d1" do
      expect(bishop.move_to('d1', occuped_cells)).to be_nil
    end

    it "can't move to e4" do
      expect(bishop.move_to('e4', occuped_cells)).to be_nil
    end

    it "can't move to e1" do
      expect(bishop.move_to('e1', occuped_cells)).to be_nil
    end

    it "can't move to f5" do
      expect(bishop.move_to('f5', occuped_cells)).to be_nil
    end

    it "can't move to h5" do
      expect(bishop.move_to('h5', occuped_cells)).to be_nil
    end

    it "can't move to h8" do
      expect(bishop.move_to('h8', occuped_cells)).to be_nil
    end
  end

  describe '#can_attack_to?' do
    subject(:bishop) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[5, 0]],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'whit a bishop at e1' do
      it 'can attack on f2' do
        expect(bishop.can_attack_to?('f2', occuped_cells)).to be(true)
      end

      it "can't attack on e3" do
        expect(bishop.can_attack_to?('e3', occuped_cells)).to be(false)
      end
    end
  end
end
