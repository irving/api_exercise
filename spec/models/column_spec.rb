# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Column, type: :model do
  let(:board) { create :board }
  let(:valid_params) { { board_id: board.id, name: 'some name' } }

  it { expect(described_class.new(board: board)).not_to be_valid }
  it { expect(described_class.new(valid_params)).to be_valid }

  context 'name' do
    before { create :column, valid_params }

    it 'rejects duplicate column name on same board' do
      expect(described_class.new(valid_params)).not_to be_valid
    end

    it 'accepts duplicate column name on different board' do
      board2 = create :board, name: 'other board'
      bad_params = { board: board2, name: valid_params[:name] }
      expect(described_class.new(bad_params)).to be_valid
    end
  end
end
