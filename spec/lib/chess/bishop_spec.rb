require 'spec_helper'

RSpec.describe Chess::Bishop do
  subject(:bishop) { described_class.new('d5', Chess::WHITE_TEAM) }

  describe 'whit a bishop on d5' do
    it 'can move to a8' do
      expect(bishop.move_to('a8')).not_to be_nil
    end

    it 'can move to g8' do
      expect(bishop.move_to('g8')).not_to be_nil
    end

    it 'can move to c6' do
      expect(bishop.move_to('c6')).not_to be_nil
    end

    it 'can move to e6' do
      expect(bishop.move_to('e6')).not_to be_nil
    end

    it 'can move to c4' do
      expect(bishop.move_to('c4')).not_to be_nil
    end

    it 'can move to e4' do
      expect(bishop.move_to('e4')).not_to be_nil
    end

    it 'can move to a2' do
      expect(bishop.move_to('a2')).not_to be_nil
    end

    it 'can move to h1' do
      expect(bishop.move_to('h1')).not_to be_nil
    end

    it "can't move to c5" do
      expect(bishop.move_to('c5')).to be_nil
    end

    it "can't move to h5" do
      expect(bishop.move_to('h5')).to be_nil
    end
  end
end
