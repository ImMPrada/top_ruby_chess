require 'spec_helper'

RSpec.describe Chess::Queen do
  subject(:queen) { described_class.new('e5', Chess::WHITE_TEAM) }

  let(:occuped_cells) do
    {
      Chess::WHITE_TEAM => [[4, 3], [4, 6], [7, 7]],
      Chess::BLACK_TEAM => [[0, 4], [2, 6], [5, 4]]
    }
  end

  describe 'with a queen on e5, and some occuped cells' do
    it 'can move to e6' do
      expect(queen.move_to('e6', occuped_cells)).not_to be_nil
    end

    it 'can move to c7' do
      expect(queen.move_to('c7', occuped_cells)).not_to be_nil
    end

    it 'can move to a5' do
      expect(queen.move_to('a5', occuped_cells)).not_to be_nil
    end

    it 'can move to b5' do
      expect(queen.move_to('b5', occuped_cells)).not_to be_nil
    end

    it 'can move to d5' do
      expect(queen.move_to('d5', occuped_cells)).not_to be_nil
    end

    it 'can move to a1' do
      expect(queen.move_to('a1', occuped_cells)).not_to be_nil
    end

    it 'can move to c3' do
      expect(queen.move_to('c3', occuped_cells)).not_to be_nil
    end

    it 'can move to g3' do
      expect(queen.move_to('g3', occuped_cells)).not_to be_nil
    end

    it 'can move to f5' do
      expect(queen.move_to('f5', occuped_cells)).not_to be_nil
    end

    it 'can move to g7' do
      expect(queen.move_to('g7', occuped_cells)).not_to be_nil
    end

    it "can't move to e7" do
      expect(queen.move_to('e7', occuped_cells)).to be_nil
    end

    it "can't move to b8" do
      expect(queen.move_to('b8', occuped_cells)).to be_nil
    end

    it "can't move to a3" do
      expect(queen.move_to('a3', occuped_cells)).to be_nil
    end

    it "can't move to d1" do
      expect(queen.move_to('d1', occuped_cells)).to be_nil
    end

    it "can't move to e4" do
      expect(queen.move_to('e4', occuped_cells)).to be_nil
    end

    it "can't move to e1" do
      expect(queen.move_to('e1', occuped_cells)).to be_nil
    end

    it "can't move to h5" do
      expect(queen.move_to('h5', occuped_cells)).to be_nil
    end

    it "can't move to h8" do
      expect(queen.move_to('h8', occuped_cells)).to be_nil
    end
  end
end
