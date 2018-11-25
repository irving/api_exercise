# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController POST create', type: :request do
  let(:board) { create :board }
  let(:name) { 'some new column' }
  let(:params) { { column: { name: name }, format: :json } }

  subject(:post_create) { post(v1_board_columns_path(board.id, params)) }

  it { expect { post_create }.to change(Column, :count).by(1) }
end
