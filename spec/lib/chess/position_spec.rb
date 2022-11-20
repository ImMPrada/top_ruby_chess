require 'spec_helper'

RSpec.describe Chess::Position do
  subject(:position) { described_class.new('a1') }

  describe 'when needs to get a string of algebraic notation' do
    it 'returns a string, using .algebraic.to_s' do
      expect(position.algebraic.to_s).to eq('a1')
    end
  end

  describe 'when needs to get an array of coordinates notation' do
    it 'returns an array, using .coordinates.to_a' do
      expect(position.coordinates.to_a).to eq([0, 0])
    end
  end
end
