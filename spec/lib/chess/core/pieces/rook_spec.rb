require 'spec_helper'
require 'chess/core/pieces/rook'
require 'chess/core/cell'
require 'chess/core/board'

RSpec.describe Chess::Core::Pieces::Rook do
  subject(:rook) { described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_a1) }

  let(:board) { Chess::Core::Board.new }
  let(:cells) do
    board.generate_cells
    board.cells
  end
  let(:cell_a1) { cells[0][0] }

  describe '.create_and_occupy' do
    it 'occupies the cell' do
      expect(rook.current_cell.occupant).to be(rook)
    end
  end

  describe 'whit other pieces occupyng cells, and starting at a1' do
    let(:cell_c3) { cells[2][2] }
    let(:cell_a4) { cells[3][0] }
    let(:cell_a8) { cells[7][0] }
    let(:cell_c1) { cells[0][2] }
    let(:cell_d1) { cells[0][3] }
    let(:cell_h1) { cells[0][7] }

    before do
      described_class.create_and_occupy(Chess::Constants::BLACK_TEAM, cell_a8)
      described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_d1)
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
          described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cells[0][2])
        end

        it 'returns false' do
          expect(rook.can_castle?(cells)).to be(false)
        end
      end

      describe '#king_side?' do
        it 'returns false' do
          expect(rook.king_side?).to be(false)
        end
      end

      describe '#queen_side?' do
        it 'returns true' do
          expect(rook.queen_side?).to be(true)
        end
      end
    end

    describe 'kingside rook' do
      subject(:rook_kingside) { described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_h8) }

      let(:cell_h8) { cells[7][7] }

      it 'returns false if the rook has moved' do
        rook_kingside.move_to(cells[7][6], cells)
        rook_kingside.move_to(cells[7][7], cells)
        expect(rook_kingside.can_castle?(cells)).to be(false)
      end

      it 'returns true if the rook has not moved' do
        expect(rook_kingside.can_castle?(cells)).to be(true)
      end

      describe '#king_side?' do
        it 'returns true' do
          expect(rook_kingside.king_side?).to be(true)
        end
      end

      describe '#queen_side?' do
        it 'returns false' do
          expect(rook_kingside.queen_side?).to be(false)
        end
      end

      describe 'when path is not free' do
        before do
          described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cells[7][5])
        end

        it 'returns false' do
          expect(rook_kingside.can_castle?(cells)).to be(false)
        end
      end
    end

    describe '#castle' do
      before { rook.castle(cells) }

      describe 'queenside' do
        let(:rook) { described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_a1) }
        let(:cell_a1) { cells[0][0] }
        let(:target_cell) { cells[0][3] }

        it 'moves the rook to the correct cell' do
          expect(target_cell.occupant).to be(rook)
        end
      end

      describe 'kingside' do
        let(:rook) { described_class.create_and_occupy(Chess::Constants::WHITE_TEAM, cell_h8) }
        let(:cell_h8) { cells[7][7] }
        let(:target_cell) { cells[7][5] }

        it 'moves the rook to the correct cell' do
          expect(target_cell.occupant).to be(rook)
        end
      end
    end
  end
end
