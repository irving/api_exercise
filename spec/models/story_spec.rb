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
    it "rejects without due date" do
      story.due_date = nil
      expect(story).not_to be_valid
    end
    it "rejects with due date in the past" do
      story.due_date = Time.zone.now - 2.days
      expect(story).not_to be_valid
    end
  end
end
