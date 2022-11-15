require 'spec_helper'

RSpec.describe Chess::Knight do
  subject(:knight) { described_class.new('d5', Chess::WHITE_TEAM) }

  describe 'whit a knight on d5' do
    it 'can move to c7' do
      expect(knight.move_to('c7')).not_to be_nil
    end

    it 'can move to e7' do
      expect(knight.move_to('e7')).not_to be_nil
    end

    it 'can move to f6' do
      expect(knight.move_to('f6')).not_to be_nil
    end

    it 'can move to f4' do
      expect(knight.move_to('f4')).not_to be_nil
    end

    it 'can move to e3' do
      expect(knight.move_to('e3')).not_to be_nil
    end

    it 'can move to c3' do
      expect(knight.move_to('c3')).not_to be_nil
    end

    it 'can move to b4' do
      expect(knight.move_to('b4')).not_to be_nil
    end

    it 'can move to b6' do
      expect(knight.move_to('b6')).not_to be_nil
    end

    it "can't move to b7" do
      expect(knight.move_to('b7')).to be_nil
    end

    it "can't move to d3" do
      expect(knight.move_to('d3')).to be_nil
    end
  end
end
