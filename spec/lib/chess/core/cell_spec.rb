require 'spec_helper'
require 'chess/core/cell'

RSpec.describe Chess::Core::Cell do
  let(:cell) { described_class.new('a1', :white) }
  let(:piece) do
    Chess::Core::Pieces::BasePiece.new(%i[R N B Q K P].sample, [Chess::WHITE_TEAM, Chess::BLACK_TEAM].sample,
                                       cell)
  end

  describe '#occupy_with' do
    before { cell.occupy_with(piece) }

    it 'occupies the cell' do
      expect(cell.instance_variable_get(:@occupant)).not_to be_nil
    end
  end

  describe '#release' do
    before do
      cell.occupy_with(piece)
      cell.release
    end

    it 'free the cell' do
      expect(cell.occupied?).to be false
    end
  end

  describe '#occupant' do
    describe 'when cell is free' do
      it 'returns nil' do
        expect(cell.occupant).to be_nil
      end
    end

    describe 'when cell is occupied' do
      it 'returns the occupant' do
        cell.occupy_with(piece)
        expect(cell.occupant).to be(piece)
      end
    end
  end

  describe '#occupied?' do
    describe 'when cell is free' do
      it 'returns false' do
        expect(cell.occupied?).to be(false)
      end
    end

    describe 'when cell is occupied' do
      it 'returns true' do
        cell.occupy_with(piece)
        expect(cell.occupied?).to be(true)
      end
    end
  end
end
