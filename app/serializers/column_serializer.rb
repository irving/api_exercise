# frozen_string_literal: true

class ColumnSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :board
  has_many :stories
end
