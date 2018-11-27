# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController POST create', type: :request do
  let(:column) { create :column }
  let(:params) do
    {
      story: {
        name: 'some new story',
        description: 'I have been described',
        due_date: (Time.zone.now.to_date + 2.days).to_s
      },
      format: :json
    }
  end

  subject(:post_create) { post(v1_column_stories_path(column.id, params)) }

  it { expect { post_create }.to change(Story, :count).by(1) }
end
