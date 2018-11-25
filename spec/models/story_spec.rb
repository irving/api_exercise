# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  context 'validations' do
    let(:story) { build :story }

    it { expect(story).to be_valid }
    it 'rejects without description' do
      story.description = nil
      expect(story).not_to be_valid
    end
    it 'rejects without due date' do
      story.due_date = nil
      expect(story).not_to be_valid
    end
    it 'rejects with due date in the past' do
      story.due_date = Time.zone.now - 2.days
      expect(story).not_to be_valid
    end
  end
  context 'late' do
    let(:column) { create(:column) }
    let(:base_due_date) { Time.now + 1.day }
    let(:stories) do
      create_list(:story, 2, column: column, due_date: base_due_date)
    end
    let(:another_story) do
      create(:story, column: column, due_date: base_due_date + 1.day)
    end

    before do
      Timecop.freeze(Time.local(2018, 11, 24, 0, 0, 30))
      stories
    end
    after { Timecop.return }

    it 'returns late stories' do
      Timecop.travel(base_due_date + 10.days) do
        expect(described_class.overdue).to eq(stories)
      end
    end
  end
end
