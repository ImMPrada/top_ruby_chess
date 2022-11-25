require 'spec_helper'

RSpec.describe Chess::Piece do
  subject(:piece) { described_class.new(position_algebraic, symbol, team) }

  let(:symbol) { :K }
  let(:position_algebraic) { 'a1' }
  let(:team) { Chess::WHITE_TEAM }

  describe '#move_to' do
    let(:position_deltas) { [[0, 1], [0, 2]] }

    describe 'when target position is possible' do
      let(:right_targe_position) { 'a3' }

      xit 'returns the new position' do
        expect(piece.move_to(right_targe_position, position_deltas).algebraic.to_s).to eq(right_targe_position)
      end
    end

    describe 'shen target position is not possible' do
      let(:wrong_target_position) { 'c2' }

      xit 'returns nil' do
        expect(piece.move_to(wrong_target_position, position_deltas)).to be_nil
      end

      xit 'keeps initial step position' do
        piece.move_to(wrong_target_position, position_deltas)
        expect(piece.instance_variable_get(:@current_step).position.algebraic.to_s).to eq(position_algebraic)
      end
    end
  end
end
