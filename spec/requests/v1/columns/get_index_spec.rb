# frozen_string_literal: true

require 'rails_helper'

describe 'V1::ColumnController GET index', type: :request do
  let(:board) { create(:board) }
  let(:columns) { create_list(:column, 2, board: board) }

  before do
    columns
    # add one from a different board to check correct scoping
    create :column
    get(v1_board_columns_path(board.id))
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response.size).to eq(columns.count) }
  it { expect(json_response.collect { |c| c[:id] }).to eq(columns.map(&:id)) }
end
