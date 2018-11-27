# frozen_string_literal: true

require 'rails_helper'

describe 'V1::ColumnsController DELETE destroy', type: :request do
  let(:board) { create :board }
  let(:column) { create :column, board: board }

  subject(:delete_destroy) { delete(v1_board_column_path(board.id, column.id)) }
  before { column }

  it { expect { delete_destroy }.to change(Column, :count).by(-1) }
  it { expect { delete_destroy }.not_to change(Board, :count) }
end
