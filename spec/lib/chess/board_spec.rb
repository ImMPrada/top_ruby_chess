require 'spec_helper'

RSpec.describe Chess::Board do
  subject(:board) { described_class.new }

  describe 'when is created' do
    let(:array_of_columns) { Chess::COLUMNS.map(&:to_sym) }
    let(:array_of_rows) { (1..8).to_a }

    it 'stores a hash in @cells property' do
      expect(board.cells).to be_a(Hash)
    end

    it 'stores a hash, with first level keys as columns names' do
      expect(board.cells.keys).to match_array(array_of_columns)
    end

    it 'stores, at each column, a hash with first level keys as row names' do
      expect(board.cells[Chess::COLUMNS.sample.to_sym].keys).to match_array(array_of_rows)
    end
  end
end
