require 'spec_helper'

RSpec.describe Chess::Core::Cell do
  let(:free_cell) { described_class.new('a1', :white) }
  let(:occupied_cell) { described_class.new('b2', :white) }
  let(:piece) do
    Chess::Core::Pieces::BasePiece.new(%i[R N B Q K P], [Chess::WHITE_TEAM, Chess::BLACK_TEAM].sample, occupied_cell)
  end

  describe '#occupy_with' do
    before { free_cell.occupy_with(piece) }

    it 'occupies the cell' do
      expect(free_cell.occupied?).to be true
    end
  end

  describe '#free' do
    before { occupied_cell.free }

    it 'free the cell' do
      expect(occupied_cell.occupied?).to be false
    end
  end

  describe '#occupant' do
    before { piece }

    describe 'when cell is free' do
      it 'returns nil' do
        expect(free_cell.occupant).to be_nil
      end
    end

    describe 'when cell is occupied' do
      it 'returns the occupant' do
        expect(occupied_cell.occupant).to be(piece)
      end
    end
  end

  describe '#occupied?' do
    before { piece }

    describe 'when cell is free' do
      it 'returns false' do
        expect(free_cell.occupied?).to be(false)
      end
    end

    describe 'when cell is occupied' do
      it 'returns true' do
        expect(occupied_cell.occupied?).to be(true)
      end
    end
  end
end
