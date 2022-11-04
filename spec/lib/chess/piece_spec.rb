require '../spec/spec_helper'

RSpec.describe Chess::Piece do
  let(:piece_symbol) { :K }
  let(:piece_coordinates) { [0, 0] }
  let(:piece_team) { Chess::WHITE_TEAM }
  let(:piece) { described_class.new(piece_coordinates, piece_symbol, piece_team) }

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

    it 'initializes a piece with a team' do
      expect(piece.instance_variable_get(:@team)).to be(piece_team)
    end

    it 'initializes a piece with a captured status false' do
      expect(piece.instance_variable_get(:@captured)).to be(false)
    end
  end

  describe '#move_to' do
    let(:right_targe_position) { 'c2' }
    let(:wrong_target_position) { 'b1' }

    it 'moves the piece to the right target position' do
      position_deltas = [[1, 2], [1, -2]]
      piece.move_to(right_targe_position, position_deltas)

      expect(piece.instance_variable_get(:@position).coordinates).to eq(position_deltas[0])
    end

    it 'does not move the piece to the wrong target position' do
      position_deltas = [[1, 2], [1, -2]]
      piece.move_to(wrong_target_position, position_deltas)

      expect(piece.instance_variable_get(:@position).coordinates).to eq(piece_coordinates)
    end
  end
end
