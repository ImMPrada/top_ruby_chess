require 'spec_helper'

RSpec.describe Chess::Core::Pieces::Pawn do
  subject(:pawn) { described_class.new(Chess::WHITE_TEAM, cell_d2) }

  let(:cells) do
    cells = []

    8.times do |row_index|
      cells << []
      8.times do |column_index|
        name = "#{%w[a b c d e f g h][column_index]}#{row_index + 1}"
        cells[row_index] << Chess::Core::Cell.new(name, Chess::WHITE_TEAM)
      end
    end

    cells
  end
  let(:cell_d2) { cells[1][3] }

  describe '#initialize' do
    before { pawn }

    it 'occupies the cell' do
      expect(cell_d2.occupant).to be(pawn)
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'whit other pieces occupyng cells, and starting at d2' do
    let(:cell_d3) { cells[2][3] }
    let(:cell_d4) { cells[3][3] }
    let(:cell_d5) { cells[4][3] }
    let(:cell_e3) { cells[2][4] }

    before do
      described_class.new(Chess::BLACK_TEAM, cell_e3)
    end

    describe '#can_move_to?' do
      it 'can move to d3 at first move' do
        expect(pawn.can_move_to?(cell_d3, cells)).to be(true)
      end

      it 'can move to d4 at first move' do
        expect(pawn.can_move_to?(cell_d4, cells)).to be(true)
      end

      it 'can move to e3 if there is an enemy' do
        expect(pawn.can_move_to?(cell_e3, cells)).to be(true)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(pawn.move_to(cell_d3, cells)).to be(cell_d3)
      end

      it 'returns nil if the move is not possible' do
        expect(pawn.move_to(cell_d5, cells)).to be_nil
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
