# frozen_string_literal: true

require 'rails_helper'

describe 'V1::StoriesController get find_by_attributes', type: :request do
  let(:column) { create :column }
  let(:due_date) { Time.zone.now + 1.day }

  before do
    Timecop.freeze Time.zone.now
  end
  after { Timecop.return }

  context 'by date' do
    let(:stories) { create_list :story, 2, due_date: due_date, column: column }

    before { stories }

    context 'with column' do
      subject(:get_find) do
        get find_by_attributes_v1_column_stories_path(column, params: params)
      end

      context 'one date' do
        let(:params) { { story: { due_date: due_date, format: :json } } }

        before { get_find }

        it { expect(json_response['stories'].size).to eq(stories.size) }
      end

      context 'multiple dates' do
        let(:dates) { [due_date, (due_date + 1.day)] }
        let(:params) { { story: { due_dates: dates, format: :json } } }
        let(:later_story) do
          create :story, due_date: due_date + 1.day, column: column
        end
        # also include a story to not be included
        let(:not_included_story) do
          create :story, due_date: (due_date + 100.days), column: column
        end
        let(:expected_stories) { [stories, later_story].flatten }
        let(:story_ids) { json_response[:stories].map { |s| s['id'] } }

        before do
          expected_stories
          not_included_story
          get_find
        end

        it { expect(json_response).to have_key(:stories) }
        it { expect(json_response[:stories].size).to eq(expected_stories.size) }
        it { expect(story_ids).not_to include(not_included_story.id) }
      end
    end
  end
  context 'by status' do
    let(:stories) do
      Story.statuses.keys.map do |status|
        create :story,
               column_id: column.id,
               due_date: due_date,
               status: status
      end
    end

    subject(:get_find) do
      get find_by_attributes_v1_column_stories_path(column, params: params)
    end

    before do
      stories
      get_find
    end

    context 'single status' do
      let(:params) { { story: { status: 'open', format: :json } } }
      let(:responded) { json_response[:stories] }
      let(:expected) { Story.find_by_status('open') }

      it { expect(responded.size).to eq(1) }
      it { expect(responded.first['id']).to eq(expected.id) }
    end

    context 'multiple statuses' do
      let(:status_list) { ['open', 'done'] }
      let(:params) { { story: { statuses: status_list, format: :json } } }
      let(:responded) { json_response[:stories] }
      let(:expected) { Story.by_status(status_list).map(&:id) }

      it { expect(responded.size).to eq(2) }
      it { expect(responded.map { |s| s['id'] }).to eq(expected) }
    end
  end

  context 'mixed status and date' do
    let(:stories) do
      Story.statuses.map do |status, index|
        create :story,
               column_id: column.id,
               due_date: due_date + index.days,
               status: status
      end
    end

    subject(:get_find) do
      get find_by_attributes_v1_column_stories_path(column, params: params)
    end

    before do
      stories
      get_find
    end

    context 'one each' do
      let(:params) do
        { story: { due_date: target_date, status: 'open', format: :json } }
      end

      let(:target_date) { due_date + 2.days }
      let(:with_status) { Story.by_status 'open' }
      let(:with_date) { Story.by_date target_date }
      let(:responded) { json_response[:stories] }
      let(:response_ids) { responded.map { |s| s['id'] } }

      it { expect(responded.size).to eq((with_status + with_date).size) }
      it { expect(response_ids).to include(with_status.first.id) }
      it { expect(response_ids).to include(with_date.first.id) }
    end
  end
end
