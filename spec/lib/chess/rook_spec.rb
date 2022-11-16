require 'spec_helper'

RSpec.describe Chess::Rook do
  subject(:rook) { described_class.new('d5', Chess::WHITE_TEAM) }

  describe 'with a rook on d5' do
    it 'can move to d8' do
      expect(rook.move_to('d8')).not_to be_nil
    end

    it 'can move to d6' do
      expect(rook.move_to('d6')).not_to be_nil
    end

    it 'can move to h5' do
      expect(rook.move_to('h5')).not_to be_nil
    end

    it 'can move to f5' do
      expect(rook.move_to('f5')).not_to be_nil
    end

    it 'can move to d1' do
      expect(rook.move_to('d1')).not_to be_nil
    end

    it 'can move to d4' do
      expect(rook.move_to('d4')).not_to be_nil
    end

    it 'can move to a5' do
      expect(rook.move_to('a5')).not_to be_nil
    end

    it 'can move to c5' do
      expect(rook.move_to('c5')).not_to be_nil
    end

    it "can't move to e3" do
      expect(rook.move_to('e3')).to be_nil
    end

    it "can't move to a1" do
      expect(rook.move_to('a1')).to be_nil
    end
  end
end
