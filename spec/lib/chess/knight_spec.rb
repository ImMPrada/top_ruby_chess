require 'spec_helper'

RSpec.describe Chess::Knight do
  describe 'with a knight on e5' do
    subject(:knight) { described_class.new('e5', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[3, 6], [6, 3]],
        Chess::BLACK_TEAM => [[2, 6], [2, 3], [5, 2]]
      }
    end

    it 'can move to f7' do
      expect(knight.move_to('f7', occuped_cells)).not_to be_nil
    end

    it 'can move to c4' do
      expect(knight.move_to('c4', occuped_cells)).not_to be_nil
    end

    it 'can move to d3' do
      expect(knight.move_to('d3', occuped_cells)).not_to be_nil
    end

    it 'can move to f3' do
      expect(knight.move_to('f3', occuped_cells)).not_to be_nil
    end

    it "can't move to d7" do
      expect(knight.move_to('d7', occuped_cells)).to be_nil
    end

    it "can't move to c7" do
      expect(knight.move_to('c7', occuped_cells)).to be_nil
    end

    it "can't move to c3" do
      expect(knight.move_to('c3', occuped_cells)).to be_nil
    end

    it "can't move to g4" do
      expect(knight.move_to('g4', occuped_cells)).to be_nil
    end
  end

  describe '#can_attack_to?' do
    subject(:knight) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[5, 0]],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'whit a knight at e1' do
      it 'can attack on f3' do
        expect(knight.can_attack_to?('f3', occuped_cells)).to be(true)
      end

      it "can't attack on f4" do
        expect(knight.can_attack_to?('f4', occuped_cells)).to be(false)
      end
    end
  end
end
