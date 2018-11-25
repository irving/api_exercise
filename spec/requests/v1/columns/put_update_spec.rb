# frozen_string_literal: true

require 'rails_helper'

describe 'V1::ColumnsController PUT update', type: :request do
  let(:original_name) { 'New Test Board' }
  let(:new_name) { 'Not the original name' }
  let(:column) { create :column, name: original_name }
  let(:params) { { column: { name: new_name, format: :json } } }

  before do
    put(v1_board_column_path(column.board_id, column.id), params: params)
  end

  it { expect(column.reload.name).to eq(new_name) }
end
