# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:valid_params) { { name: 'test' } }

  context 'validations' do
    it { expect(described_class.new).not_to be_valid }
    it { expect(described_class.new(valid_params)).to be_valid }

    it 'fails on duplicate name' do
      create :board
      expect(build(:board)).not_to be_valid
    end
  end
end
