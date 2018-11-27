# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController GET index', type: :request do
  let(:column) { create(:column) }
  let(:stories) { create_list(:story, 2, column: column) }

  before do
    stories
    # add one in another column to check correct scoping
    create :story
    get(v1_column_stories_path(column.id))
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response.size).to eq(stories.count) }
  it { expect(json_response.collect { |s| s[:id] }).to eq(stories.map(&:id)) }
end
