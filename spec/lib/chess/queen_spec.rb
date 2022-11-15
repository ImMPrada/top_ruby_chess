require 'spec_helper'

RSpec.describe Chess::Queen do
  subject(:queen) { described_class.new('d5', Chess::WHITE_TEAM) }

  describe 'whit a queen on d5' do
    it 'can move to d8' do
      expect(queen.move_to('d8')).not_to be_nil
    end

    it 'can move to g8' do
      expect(queen.move_to('g8')).not_to be_nil
    end

    it 'can move to e5' do
      expect(queen.move_to('e5')).not_to be_nil
    end

    it 'can move to e4' do
      expect(queen.move_to('e4')).not_to be_nil
    end

    it 'can move to d4' do
      expect(queen.move_to('d4')).not_to be_nil
    end

    it 'can move to c4' do
      expect(queen.move_to('c4')).not_to be_nil
    end

    it 'can move to a5' do
      expect(queen.move_to('a5')).not_to be_nil
    end

    it 'can move to b7' do
      expect(queen.move_to('b7')).not_to be_nil
    end

    it "can't move to a1" do
      expect(queen.move_to('a1')).to be_nil
    end

    it "can't move to g6" do
      expect(queen.move_to('g6')).to be_nil
    end
  end
end
