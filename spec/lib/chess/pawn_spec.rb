require 'spec_helper'

RSpec.describe Chess::Pawn do
  subject(:pawn) { described_class.new('e2', Chess::WHITE_TEAM) }

  describe 'with a pawn on e2' do
    it 'can move to e4 at first move' do
      expect(pawn.move_to('e4')).not_to be_nil
    end

    it "can't move to e6 from e4 in ine turn" do
      pawn.move_to('e4')
      expect(pawn.move_to('e6')).to be_nil
    end

    it "can't move to e1" do
      expect(pawn.move_to('e1')).to be_nil
    end

    describe 'when is capturing' do
      it 'can move to f3' do
        expect(pawn.move_to('f3', true)).not_to be_nil
      end

      it 'can move to d3' do
        expect(pawn.move_to('d3', true)).not_to be_nil
      end

      it "can't move to e3" do
        expect(pawn.move_to('e3', true)).to be_nil
      end

      it "can't move to e4" do
        expect(pawn.move_to('e4', true)).to be_nil
      end

      it "can't move to e1" do
        expect(pawn.move_to('e1', true)).to be_nil
      end
    end
  end
end
