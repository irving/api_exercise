# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController DELETE destroy', type: :request do
  let(:story) { create :story }

  subject(:delete_destroy) do
    delete(v1_column_story_path(story.column_id, story.id))
  end
  before { story }

  it { expect { delete_destroy }.to change(Story, :count).by(-1) }
  it { expect { delete_destroy }.not_to change(Column, :count) }
end
