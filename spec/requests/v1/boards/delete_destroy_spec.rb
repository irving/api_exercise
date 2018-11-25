# frozen_string_literal: true

require 'rails_helper'

describe 'V1::BoardsController DELETE destroy', type: :request do
  let(:board) { create :board }

  subject(:delete_destroy) { delete(v1_board_path(id: board.id)) }
  before { board }

  it { expect { delete_destroy }.to change(Board, :count).by(-1) }
end
