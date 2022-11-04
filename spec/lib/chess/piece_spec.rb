require './spec/spec_helper'

RSpec.describe Chess::Piece do
  let(:piece_symbol) { :K }
  let(:piece_coordinates) { [0, 0] }
  let(:piece) { described_class.new(piece_coordinates, piece_symbol) }

  describe '#initialize' do
    it 'initializes a piece with a position' do
      expect(piece.instance_variable_get(:@position).coordinates).to be(piece_coordinates)
    end

    it 'initializes a piece with a symbol' do
      expect(piece.instance_variable_get(:@symbol)).to be(piece_symbol)
    end

    it 'piece\'s position is a node type' do
      expect(piece.instance_variable_get(:@position)).to be_a(Chess::Node)
    end
  end
end
