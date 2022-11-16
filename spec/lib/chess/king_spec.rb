require 'spec_helper'

RSpec.describe Chess::King do
  subject(:king) { described_class.new('d5', Chess::WHITE_TEAM) }

  describe 'with a king on d5' do
    it 'can move to d6' do
      expect(king.move_to('d6')).not_to be_nil
    end

    it 'can move to e6' do
      expect(king.move_to('e6')).not_to be_nil
    end

    it 'can move to e5' do
      expect(king.move_to('e5')).not_to be_nil
    end

    it 'can move to e4' do
      expect(king.move_to('e4')).not_to be_nil
    end

    it 'can move to d4' do
      expect(king.move_to('d4')).not_to be_nil
    end

    it 'can move to c4' do
      expect(king.move_to('c4')).not_to be_nil
    end

    it 'can move to c5' do
      expect(king.move_to('c5')).not_to be_nil
    end

    it 'can move to c6' do
      expect(king.move_to('c6')).not_to be_nil
    end

    it "can't move to d7" do
      expect(king.move_to('d7')).to be_nil
    end
  end
end
