# frozen_string_literal: true

# A column is a single ordered list of stories (cards)
class Column < ApplicationRecord
  belongs_to :board
  validates :name, presence: true, uniqueness:
    { scope: :board_id, message: 'Name must be unique to this board' }
end
