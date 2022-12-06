require 'spec_helper'
require 'chess/core/record'
require 'chess/core/board'

require_relative '../../../helpers/record_pieces'

Intention = Struct.new(:type, :origin_cell, :target_cell)

RSpec.describe Chess::Core::Record do
  include Helpers::RecordPieces

  subject(:record) { described_class.new }

  let(:board) { Chess::Core::Board.new }

  before do
    board.generate_cells
    hardcode_record_case1(board)
  end

  describe '#add' do
    describe 'when intention is type :move and no capture' do
      let(:accomplished_intention) { Intention.new(:move, board.cells[0][4], board.cells[1][4]) }
      let(:record_add) { record.add(accomplished_intention, Chess::WHITE_TEAM, nil) }

      it 'returns a Chess::Core::Record::CommitRecord' do
        expect(
          record_add
        ).to be_a(Chess::Core::Record::CommitRecord)
      end

      it 'returns a Chess::Core::Record::CommitRecord with piece symbol' do
        expect(
          record_add.piece
        ).to be(board.cells[1][4].occupant.symbol)
      end

      it 'returns a Chess::Core::Record::CommitRecord with origin cell name' do
        expect(
          record_add.origin
        ).to be(board.cells[0][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with target cell name' do
        expect(
          record_add.target
        ).to be(board.cells[1][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with capture true' do
        expect(
          record_add.capture
        ).to be_nil
      end

      it 'updates history' do
        before_add = record.history.first[Chess::WHITE_TEAM].nil?
        record.add(accomplished_intention, Chess::WHITE_TEAM, nil)
        expect(
          before_add == record.history.first[Chess::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record.add(accomplished_intention, Chess::WHITE_TEAM, nil)
        expect(record.history.first[Chess::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end

    describe 'when intention is type :move and capture' do
      let(:accomplished_intention) { Intention.new(:move, board.cells[0][4], board.cells[1][4]) }
      let(:record_add) { record.add(accomplished_intention, Chess::WHITE_TEAM, true) }

      it 'returns a Chess::Core::Record::CommitRecord' do
        expect(
          record_add
        ).to be_a(Chess::Core::Record::CommitRecord)
      end

      it 'returns a Chess::Core::Record::CommitRecord with piece symbol' do
        expect(
          record_add.piece
        ).to be(board.cells[1][4].occupant.symbol)
      end

      it 'returns a Chess::Core::Record::CommitRecord with origin cell name' do
        expect(
          record_add.origin
        ).to be(board.cells[0][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with target cell name' do
        expect(
          record_add.target
        ).to be(board.cells[1][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with capture true' do
        expect(
          record_add.capture
        ).to be(true)
      end

      it 'updates history' do
        before_add = record.history.first[Chess::WHITE_TEAM].nil?
        record_add
        expect(
          before_add == record.history.first[Chess::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record_add
        expect(record.history.first[Chess::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end

    describe 'when intention is type castling' do
      let(:accomplished_intention) { Intention.new(Chess::KING_CASTLING_INTENTION, nil, nil) }
      let(:record_add) { record.add(accomplished_intention, Chess::WHITE_TEAM, nil) }

      it 'returns nil at piece symbol' do
        expect(
          record_add.piece
        ).to be_nil
      end

      it 'returns nil at piece origin' do
        expect(
          record_add.origin
        ).to be_nil
      end

      it 'returns nil at piece target' do
        expect(
          record_add.target
        ).to be_nil
      end

      it 'returns castling type at castling' do
        expect(
          record_add.castling
        ).to be(Chess::KING_CASTLING_INTENTION)
      end

      it 'updates history' do
        before_add = record.history.first[Chess::WHITE_TEAM].nil?
        record_add
        expect(
          before_add == record.history.first[Chess::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record_add
        expect(record.history.first[Chess::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end
  end
end
