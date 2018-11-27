# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  attribute :due_date do
    object.due_date.to_date.to_s
  end

  belongs_to :column
end
