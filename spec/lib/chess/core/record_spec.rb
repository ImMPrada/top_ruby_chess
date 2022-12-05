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

      it 'returns a Chess::Core::Record::CommitRecord' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil)
        ).to be_a(Chess::Core::Record::CommitRecord)
      end

      it 'returns a Chess::Core::Record::CommitRecord with piece symbol' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).piece
        ).to be(board.cells[1][4].occupant.symbol)
      end

      it 'returns a Chess::Core::Record::CommitRecord with origin cell name' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).origin
        ).to be(board.cells[0][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with target cell name' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).target
        ).to be(board.cells[1][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with capture true' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).capture
        ).to be_nil
      end

      it 'updates history' do
        before_add = record.history.first[Chess::Constants::WHITE_TEAM].nil?
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil)
        expect(
          before_add == record.history.first[Chess::Constants::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil)
        expect(record.history.first[Chess::Constants::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end

    describe 'when intention is type :move and capture' do
      let(:accomplished_intention) { Intention.new(:move, board.cells[0][4], board.cells[1][4]) }

      it 'returns a Chess::Core::Record::CommitRecord' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true)
        ).to be_a(Chess::Core::Record::CommitRecord)
      end

      it 'returns a Chess::Core::Record::CommitRecord with piece symbol' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true).piece
        ).to be(board.cells[1][4].occupant.symbol)
      end

      it 'returns a Chess::Core::Record::CommitRecord with origin cell name' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true).origin
        ).to be(board.cells[0][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with target cell name' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true).target
        ).to be(board.cells[1][4].name)
      end

      it 'returns a Chess::Core::Record::CommitRecord with capture true' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true).capture
        ).to be(true)
      end

      it 'updates history' do
        before_add = record.history.first[Chess::Constants::WHITE_TEAM].nil?
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true)
        expect(
          before_add == record.history.first[Chess::Constants::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, true)
        expect(record.history.first[Chess::Constants::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end

    describe 'when intention is type castling' do
      let(:accomplished_intention) { Intention.new(Chess::Constants::INTENTION_IS_KING_CASTLING, nil, nil) }

      it 'returns nil at piece symbol' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).piece
        ).to be_nil
      end

      it 'returns nil at piece origin' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).origin
        ).to be_nil
      end

      it 'returns nil at piece target' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).target
        ).to be_nil
      end

      it 'returns castling type at castling' do
        expect(
          record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil).castling
        ).to be(Chess::Constants::INTENTION_IS_KING_CASTLING)
      end

      it 'updates history' do
        before_add = record.history.first[Chess::Constants::WHITE_TEAM].nil?
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil)
        expect(
          before_add == record.history.first[Chess::Constants::WHITE_TEAM].nil?
        ).to be(false)
      end

      it 'updates history with a Chess::Core::Record::CommitRecord' do
        record.add(accomplished_intention, Chess::Constants::WHITE_TEAM, nil)
        expect(record.history.first[Chess::Constants::WHITE_TEAM]).to be_a(Chess::Core::Record::CommitRecord)
      end
    end
  end
end
