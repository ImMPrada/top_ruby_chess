require 'spec_helper'
require 'chess/core/pieces/bishop'
require 'chess/core/cell'

RSpec.describe Chess::Core::Pieces::Bishop do
  subject(:bishop) { described_class.create_and_occupy(Chess::WHITE_TEAM, cell_d4) }

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
  let(:cell_d4) { cells[3][3] }

  describe '.create_and_occupy' do
    it 'occupies the cell' do
      expect(bishop.current_cell.occupant).to be(bishop)
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'whit the bishop starting at d4' do
    let(:cell_a1) { cells[0][0] }
    let(:cell_a7) { cells[6][0] }
    let(:cell_b6) { cells[5][1] }
    let(:cell_e5) { cells[4][4] }
    let(:cell_e3) { cells[2][4] }
    let(:cell_d5) { cells[4][3] }

    describe '#can_move_to?' do
      it 'can move to a1' do
        expect(bishop.can_move_to?(cell_a1, cells)).to be(true)
      end

      it 'can move to a7' do
        expect(bishop.can_move_to?(cell_a7, cells)).to be(true)
      end

      it 'can move to b6' do
        expect(bishop.can_move_to?(cell_b6, cells)).to be(true)
      end

      it 'can move to e5' do
        expect(bishop.can_move_to?(cell_e5, cells)).to be(true)
      end

      it 'can move to e3' do
        expect(bishop.can_move_to?(cell_e3, cells)).to be(true)
      end

      it "can't move to d5" do
        expect(bishop.can_move_to?(cell_d5, cells)).to be(false)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(bishop.move_to(cell_a1, cells)).to be(cell_a1)
      end

      it 'returns nil if the move is not possible' do
        expect(bishop.move_to(cell_d5, cells)).to be_nil
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'whit other pieces occupyng cells, and starting at d4' do
    let(:cell_a1) { cells[0][0] }
    let(:cell_c3) { cells[2][2] }
    let(:cell_h8) { cells[7][7] }
    let(:cell_d7) { cells[6][3] }
    let(:cell_f2) { cells[1][5] }
    let(:cell_g1) { cells[0][6] }

    before do
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_c3)
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_h8)
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_d7)
      described_class.create_and_occupy(Chess::WHITE_TEAM, cell_f2)
    end

    describe '#can_move_to?' do
      it 'can move to c3' do
        expect(bishop.can_move_to?(cell_c3, cells)).to be(true)
      end

      it 'can move to h8' do
        expect(bishop.can_move_to?(cell_h8, cells)).to be(true)
      end

      it "can't move to a1" do
        expect(bishop.can_move_to?(cell_a1, cells)).to be(false)
      end

      it "can't move to d7" do
        expect(bishop.can_move_to?(cell_d7, cells)).to be(false)
      end

      it "can't move to f2" do
        expect(bishop.can_move_to?(cell_f2, cells)).to be(false)
      end

      it "can't move to g1" do
        expect(bishop.can_move_to?(cell_g1, cells)).to be(false)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(bishop.move_to(cell_c3, cells)).to be(cell_c3)
      end

      it 'returns nil if the move is not possible' do
        expect(bishop.move_to(cell_a1, cells)).to be_nil
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
