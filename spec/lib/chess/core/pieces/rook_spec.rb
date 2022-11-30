require 'spec_helper'
require 'chess/core/pieces/rook'
require 'chess/core/cell'

RSpec.describe Chess::Core::Pieces::Rook do
  subject(:rook) { described_class.create_and_occupy(Chess::WHITE_TEAM, cell_a1) }

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
  let(:cell_a1) { cells[0][0] }

  describe '.create_and_occupy' do
    it 'occupies the cell' do
      expect(rook.current_cell.occupant).to be(rook)
    end

    it 'defines the side' do
      expect(rook.side).not_to be_nil
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe 'whit other pieces occupyng cells, and starting at a1' do
    let(:cell_c3) { cells[2][2] }
    let(:cell_a4) { cells[3][0] }
    let(:cell_a8) { cells[7][0] }
    let(:cell_c1) { cells[0][2] }
    let(:cell_d1) { cells[0][3] }
    let(:cell_h1) { cells[0][7] }

    before do
      described_class.create_and_occupy(Chess::BLACK_TEAM, cell_a8)
      described_class.create_and_occupy(Chess::WHITE_TEAM, cell_d1)
    end

    describe '#can_move_to?' do
      it 'can move to a4' do
        expect(rook.can_move_to?(cell_a4, cells)).to be(true)
      end

      it 'can move to a8' do
        expect(rook.can_move_to?(cell_a8, cells)).to be(true)
      end

      it 'can move to c1' do
        expect(rook.can_move_to?(cell_c1, cells)).to be(true)
      end

      it "can't move to h1" do
        expect(rook.can_move_to?(cell_h1, cells)).to be(false)
      end

      it "can't move to d1" do
        expect(rook.can_move_to?(cell_d1, cells)).to be(false)
      end

      it "can't move to c3" do
        expect(rook.can_move_to?(cell_c3, cells)).to be(false)
      end
    end

    describe '#move_to' do
      it 'returns target cell' do
        expect(rook.move_to(cell_a8, cells)).to be(cell_a8)
      end

      it 'returns nil if the move is not possible' do
        expect(rook.move_to(cell_h1, cells)).to be_nil
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers

  # rubocop:disable RSpec/NestedGroups
  describe '#can_castle?' do
    describe 'queenside rook' do
      it 'returns false if the rook has moved' do
        rook.move_to(cells[0][7], cells)
        rook.move_to(cells[0][0], cells)
        expect(rook.can_castle?(cells)).to be(false)
      end

      it 'returns true if the rook has not moved' do
        expect(rook.can_castle?(cells)).to be(true)
      end

      describe 'when path is not free' do
        before do
          described_class.create_and_occupy(Chess::WHITE_TEAM, cells[0][2])
        end

        it 'returns false' do
          expect(rook.can_castle?(cells)).to be(false)
        end
      end
    end
    # rubocop:enable RSpec/NestedGroups

    # rubocop:disable RSpec/NestedGroups
    describe 'kingside rook' do
      subject(:rook_kingside) { described_class.create_and_occupy(Chess::WHITE_TEAM, cell_h8) }

      let(:cell_h8) { cells[7][7] }

      it 'returns false if the rook has moved' do
        rook_kingside.move_to(cells[7][6], cells)
        rook_kingside.move_to(cells[7][7], cells)
        expect(rook_kingside.can_castle?(cells)).to be(false)
      end

      it 'returns true if the rook has not moved' do
        expect(rook_kingside.can_castle?(cells)).to be(true)
      end

      describe 'when path is not free' do
        before do
          described_class.create_and_occupy(Chess::WHITE_TEAM, cells[7][5])
        end

        it 'returns false' do
          expect(rook_kingside.can_castle?(cells)).to be(false)
        end
      end
    end
    # rubocop:enable RSpec/NestedGroups
  end
end
