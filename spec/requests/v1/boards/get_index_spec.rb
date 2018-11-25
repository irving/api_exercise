# frozen_string_literal: true

require 'rails_helper'

describe 'V1::BoardsController GET index', type: :request do
  let(:boards) { create_list(:board, 2) }
  let(:board_ids) { Board.all.map(&:id) }

  before do
    boards
    get(v1_boards_path)
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response.size).to eq(Board.count) }
  it { expect(json_response.collect { |b| b[:id] }).to eq(board_ids) }
end
