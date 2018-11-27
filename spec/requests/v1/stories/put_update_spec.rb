# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController PUT update', type: :request do
  let(:new_description) { 'Not the original description' }
  let(:due_date) { Time.zone.now + 2.days }
  let(:story) { create :story, due_date: due_date, description: 'fake' }
  let(:params) { { story: { description: new_description, format: :json } } }

  before do
    put(v1_column_story_path(story.column_id, story.id), params: params)
  end

  it { expect(story.reload.description).to eq(new_description) }
  # unchanged
  it { expect(story.reload.due_date.to_date).to eq(due_date.to_date) }
end
