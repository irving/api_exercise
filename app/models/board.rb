# frozen_string_literal: true

# A board is a collection of named columns (lists) of stories.
class Board < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :columns
end
