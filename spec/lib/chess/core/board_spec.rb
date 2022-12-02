require 'spec_helper'
require 'chess/core/board'
require 'chess/core/cell'

RSpec.describe Chess::Core::Board do
  describe '#create_and_occupy' do
    subject(:board) { described_class.create_and_occupy }

    it 'creates an array at @cells' do
      expect(board.cells).to be_a(Array)
    end

    it 'all items in @cells are cells' do
      cells = board.cells
      check = cells.all? do |cells_row|
        cells_row.all? { |cell| cell.instance_of?(Chess::Core::Cell) }
      end

      expect(check).to be(true)
    end

    it 'creates a hash at @pieces' do
      expect(board.pieces).to be_a(Hash)
    end

    it 'creates a king for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:K).size).to be(1)
    end

    it 'creates a king for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:K).size).to be(1)
    end

    it 'creates a queen for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:Q).size).to be(1)
    end

    it 'creates a queen for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:Q).size).to be(1)
    end

    it 'creates 2 bishops for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:B).size).to be(2)
    end

    it 'creates 2 bishops for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:B).size).to be(2)
    end

    it 'creates 2 knights for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:N).size).to be(2)
    end

    it 'creates 2 knights for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:N).size).to be(2)
    end

    it 'creates 2 rooks for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:R).size).to be(2)
    end

    it 'creates 2 rooks for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:R).size).to be(2)
    end

    it 'creates 8 rooks for white team' do
      expect(board.pieces[Chess::WHITE_TEAM].find_pieces_of(:P).size).to be(8)
    end

    it 'creates 8 rooks for black team' do
      expect(board.pieces[Chess::BLACK_TEAM].find_pieces_of(:P).size).to be(8)
    end
  end

  describe '#can_any_piece_move_to?' do
    subject(:board) { described_class.new }

    let(:cells) { board.cells }

    before { board.generate_cells }

    describe 'when cells are all released' do
      it 'returns nil' do
        expect(board.can_any_piece_move_to?(
                 cells.sample.sample,
                 cells,
                 board.pieces
               )).to be_nil
      end
    end

    describe 'with a bishop at a1' do
      let(:bishop) { Chess::Core::Pieces::Bishop.create_and_occupy(Chess::WHITE_TEAM, cells[0][0]) }

      it 'returns true when a cell is at c3' do
        expect(board.can_any_piece_move_to?(
                 cells[2][2],
                 cells,
                 [bishop]
               )).to be(true)
      end

      it 'returns false when a cell is at c4' do
        expect(board.can_any_piece_move_to?(
                 cells[3][2],
                 cells,
                 [bishop]
               )).to be(false)
      end

      # rubocop:disable RSpec/NestedGroups
      describe 'with also a rook at h4' do
        let(:rook) { Chess::Core::Pieces::Rook.create_and_occupy(Chess::WHITE_TEAM, cells[3][7]) }

        it 'returns false when a cell is at c4' do
          expect(board.can_any_piece_move_to?(
                   cells[3][2],
                   cells,
                   [bishop, rook]
                 )).to be(true)
        end
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
