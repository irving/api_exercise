# frozen_string_literal: true

require 'rails_helper'

describe 'V1::ColumnsController GET show', type: :request do
  let(:board) { create :board }
  let(:column) { create :column, board: board }
  let(:stories) { create_list :story, 3, column: column }

  before do
    stories
    get(v1_board_column_path(board.id, column.id))
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response['name']).to eq(column.name) }
  it { expect(json_response).to have_key('stories') }
  it { expect(json_response['stories'].size).to eq(stories.size) }
end
