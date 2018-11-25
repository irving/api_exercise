class StorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :due_date

  belongs_to :column
end
