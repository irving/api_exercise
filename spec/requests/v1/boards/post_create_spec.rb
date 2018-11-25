# frozen_string_literal: true

require 'rails_helper'

describe 'V1::BoardsController POST create', type: :request do
  let(:name) { 'New Test Board' }
  let(:params) { { board: { name: name }, format: :json } }

  subject(:post_create) { post(v1_boards_path(params)) }

  it { expect { post_create }.to change(Board, :count).by(1) }

  context 'failure' do
    before { create :board, name: name }

    it { expect { post_create }.not_to change(Board, :count) }
  end
end
