require 'spec_helper'

RSpec.describe Chess::King do
  describe 'with a king on e5' do
    subject(:king) { described_class.new('e5', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[3, 5], [4, 5]],
        Chess::BLACK_TEAM => [[3, 4], [5, 4]]
      }
    end

    it 'can move to f6' do
      expect(king.move_to('f6', occuped_cells)).not_to be_nil
    end

    it 'can move to d4' do
      expect(king.move_to('d4', occuped_cells)).not_to be_nil
    end

    it 'can move to f4' do
      expect(king.move_to('f4', occuped_cells)).not_to be_nil
    end

    it 'can move to f5' do
      expect(king.move_to('f5', occuped_cells)).not_to be_nil
    end

    it "can't move to e6" do
      expect(king.move_to('e6', occuped_cells)).to be_nil
    end

    it "can't move to d6" do
      expect(king.move_to('d6', occuped_cells)).to be_nil
    end

    it "can't move to g7" do
      expect(king.move_to('g7', occuped_cells)).to be_nil
    end
  end

  describe '#can_castling' do
    subject(:king) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'when is first move' do
      it 'returns true' do
        expect(king.can_castling?).to be(true)
      end
    end

    describe "when isn't first move" do
      it 'returns false' do
        king.move_to('e2', occuped_cells)
        king.move_to('e1', occuped_cells)
        expect(king.can_castling?).to be(false)
      end
    end
  end

  describe '#castle_with' do
    subject(:king) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:rook_queen) { Chess::Rook.new('a1', Chess::WHITE_TEAM) }
    let(:rook_king) { Chess::Rook.new('h1', Chess::WHITE_TEAM) }
    let(:side_to_castling) { [Chess::KING_SIDE, Chess::QUEEN_SIDE].sample }
    let(:rook_for_castling) do
      case side_to_castling
      when Chess::KING_SIDE
        rook_king
      when Chess::QUEEN_SIDE
        rook_queen
      end
    end

    describe 'when row between rook and king, is empty' do
      let(:occuped_cells) do
        {
          Chess::WHITE_TEAM => [[0, 0], [4, 0], [7, 0]],
          Chess::BLACK_TEAM => []
        }
      end

      it 'can castle' do
        expect(king.castle_with(rook_for_castling, occuped_cells, side_to_castling)).not_to be_nil
      end

      it "updates king's step position" do
        initial_position = king.position.algebraic.to_s
        king.castle_with(rook_for_castling, occuped_cells, side_to_castling)
        ending_position = king.position.algebraic.to_s

        expect(initial_position).not_to eq(ending_position)
      end

      it "updates rooks's step position" do
        initial_position = rook_for_castling.position.algebraic.to_s
        king.castle_with(rook_for_castling, occuped_cells, side_to_castling)
        ending_position = rook_for_castling.position.algebraic.to_s

        expect(initial_position).not_to eq(ending_position)
      end
    end

    describe 'when row between rook and king, is not empty' do
      let(:occuped_cells) do
        {
          Chess::WHITE_TEAM => [[0, 0], [3, 0], [4, 0], [6, 0], [7, 0]],
          Chess::BLACK_TEAM => []
        }
      end

      it "can't castle" do
        expect(king.castle_with(rook_for_castling, occuped_cells, side_to_castling)).to be_nil
      end
    end
  end

  describe '#can_attack_to?' do
    subject(:king) { described_class.new('e1', Chess::WHITE_TEAM) }

    let(:occuped_cells) do
      {
        Chess::WHITE_TEAM => [[5, 0]],
        Chess::BLACK_TEAM => []
      }
    end

    describe 'whit a king at e1' do
      it 'can attack on f2' do
        expect(king.can_attack_to?('f2', occuped_cells)).to be(true)
      end

      it "can't attack on e3" do
        expect(king.can_attack_to?('e3', occuped_cells)).to be(false)
      end
    end
  end
end
