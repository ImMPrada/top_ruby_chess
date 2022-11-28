require 'spec_helper'

RSpec.describe Chess::Core::Pieces::Queen do
  subject(:queen) { described_class.new(Chess::WHITE_TEAM, cell_e5) }

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
  let(:cell_e5) { cells[4][4] }

  describe '#initialize' do
    before { queen }

    it 'occupies the cell' do
      expect(cell_e5.occupant).to be(queen)
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'whit other pieces occupyng cells, and starting at e5' do
    let(:cell_c3) { cells[2][2] }
    let(:cell_d5) { cells[4][3] }
    let(:cell_e8) { cells[7][4] }
    let(:cell_e1) { cells[0][4] }
    let(:cell_h7) { cells[7][7] }
    let(:cell_h5) { cells[4][7] }
    let(:cell_h2) { cells[1][7] }
    let(:cell_a1) { cells[0][0] }
    let(:cell_a5) { cells[4][0] }
    let(:cell_b5) { cells[4][1] }

    before do
      described_class.new(Chess::BLACK_TEAM, cell_c3)
      described_class.new(Chess::WHITE_TEAM, cell_b5)
    end

    describe '#can_move_to?' do
      it 'can move to c3' do
        expect(queen.can_move_to?(cell_c3, cells)).to be(true)
      end

      it 'can move to d5' do
        expect(queen.can_move_to?(cell_d5, cells)).to be(true)
      end

      it 'can move to e8' do
        expect(queen.can_move_to?(cell_e8, cells)).to be(true)
      end

      it 'can move to e1' do
        expect(queen.can_move_to?(cell_e1, cells)).to be(true)
      end

      it 'can move to h7' do
        expect(queen.can_move_to?(cell_h7, cells)).to be(true)
      end

      it 'can move to h5' do
        expect(queen.can_move_to?(cell_h5, cells)).to be(true)
      end

      it 'can move to h2' do
        expect(queen.can_move_to?(cell_h2, cells)).to be(true)
      end

      it "can't move to a1" do
        expect(queen.can_move_to?(cell_a1, cells)).to be(false)
      end

      it "can't move to a5" do
        expect(queen.can_move_to?(cell_a5, cells)).to be(false)
      end

      it "can't move to b5" do
        expect(queen.can_move_to?(cell_b5, cells)).to be(false)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(queen.move_to(cell_d5, cells)).to be(cell_d5)
      end

      it 'returns nil if the move is not possible' do
        expect(queen.move_to(cell_a1, cells)).to be_nil
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
