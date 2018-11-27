# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController GET show', type: :request do
  let(:column) { create :column }
  let(:story) { create :story, column: column }
  let(:due_date) { story.due_date.to_date.to_s }

  before do
    get(v1_column_story_path(column.id, story.id))
  end

  it { expect(response.status).to eq(200) }
  it { expect(json_response['name']).to eq(story.name) }
  it { expect(json_response['description']).to eq(story.description) }
  it { expect(json_response['due_date']).to eq(due_date) }
end
