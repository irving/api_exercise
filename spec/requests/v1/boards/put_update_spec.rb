# frozen_string_literal: true

require 'rails_helper'

describe 'V1::BoardsController PUT update', type: :request do
  let(:original_name) { 'New Test Board' }
  let(:new_name) { 'Not the original name' }
  let(:board) { create(:board, name: original_name) }
  let(:params) { { board: { name: new_name, format: :json } } }

  before { put(v1_board_path(id: board.id), params: params) }

  it { expect(board.reload.name).to eq(new_name) }
end
