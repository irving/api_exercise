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
    it 'rejects invalid status' do
      expect { story.status = 'bad status' }.to raise_error(ArgumentError)
    end
  end
  context 'scopes' do
    let(:column) { create :column }

    context 'late' do
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
    context 'by status' do
      let(:target_status) { 'open' }

      before do
        described_class.statuses.keys.each do |status|
          create :story, status: status, column: column
        end
      end
      context 'by one status' do
        let(:stories) { described_class.by_status(target_status) }

        it { expect(stories.count).to eq(1) }
        it { expect(stories.first.status).to eq(target_status) }
      end
      context 'by multiple statuses' do
        let(:statuses) { %w[open done] }
        let(:stories) { described_class.by_status(statuses) }
        let(:returned_statuses) { stories.map(&:status) }

        it { expect(stories.count).to eq(statuses.size) }
        it 'matched the correct statuses' do
          expect(returned_statuses).to eq(statuses)
        end
      end
      context 'by_column_id' do
        let(:column2) { create :column }
        let(:other_story) { create :story, column: column2, status: 'open' }
        let(:stories) { described_class.by_column_id(column.id) }

        it { expect(stories).not_to include(other_story) }
        it { expect(stories.map(&:column_id).uniq.first).to eq(column.id) }
      end

      context 'by_date' do
        let(:target_date1) { (Time.zone.now + 3.days) }
        let(:by_date) { described_class.by_date(target_date1) }

        # update due dates on the existing stories so they are all different.
        before do
          Timecop.freeze Time.zone.now
          days = 3
          described_class.all.each do |story|
            story.update_attribute :due_date, (Time.zone.now + days.days)
            days += 1
          end
        end
        after { Timecop.return }

        context 'with one date' do
          it { expect(by_date.size).to eq(1) }
          it { expect(by_date[0].due_date.to_date).to eq(target_date1.to_date) }
        end
        context 'with multiple dates' do
          let(:target_date2) { (Time.zone.now + 4.days) }
          let(:targets) { [target_date1.to_date, target_date2.to_date] }
          let(:by_dates) { described_class.by_dates(targets) }

          it { expect(by_dates.size).to eq(2) }
          it { expect(by_dates.map(&:due_date).map(&:to_date)).to eq(targets) }
        end
      end
    end
  end
end
