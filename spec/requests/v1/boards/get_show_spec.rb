# frozen_string_literal: true

require 'rails_helper'

describe 'V1::BoardsController GET show', type: :request do
  let(:board) { create :board }
  let(:columns) { create_list :column, 2, board: board }

  before do
    columns
    get(v1_board_path(board.id))
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response['name']).to eq(board.name) }
  it { expect(json_response).to have_key('columns') }
  it { expect(json_response['columns'].size).to eq(columns.size) }
end
