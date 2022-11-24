require 'spec_helper'

RSpec.describe Chess::Prompt do
  subject(:prompt) { described_class.new }

  describe '#input' do
    describe 'when a wrong input' do
      let(:wrong_input) { ['', 'bla_bla', 'totally wrong', 'ng3', 'ng3g', '-asd'].sample }

      it 'returns an error' do
        expect(prompt.input(wrong_input)).to be(Chess::ERR_WRONG_INPUT)
      end

      it 'sets input_string to nil' do
        prompt.input(wrong_input)
        expect(prompt.input_string).to be_nil
      end
    end

    describe 'when input is a movement' do
      let(:right_input) { 'pg2g3' }

      it 'returns movement case' do
        expect(prompt.input(right_input)).to be(Chess::CASE_MOVEMENT)
      end

      it 'updates parameters resulting' do
        prompt.input(right_input)
        expect(prompt.parameters).to eq('pg2g3'.scan(Chess::Prompt::PIECE_MOVE_SCAN_REGEX))
      end
    end

    describe 'when input is kingside castling' do
      let(:right_input) { 'o-o' }

      it 'returns movement case' do
        expect(prompt.input(right_input)).to be(Chess::CASE_CASTLE)
      end

      it 'updates parameters resulting' do
        prompt.input(right_input)
        expect(prompt.parameters).to be(Chess::KING_SIDE)
      end
    end

    describe 'when input is queenside castling' do
      let(:right_input) { 'o-o-o' }

      it 'returns movement case' do
        expect(prompt.input(right_input)).to be(Chess::CASE_CASTLE)
      end

      it 'updates parameters resulting' do
        prompt.input(right_input)
        expect(prompt.parameters).to be(Chess::QUEEN_SIDE)
      end
    end
  end
end
