# frozen_string_literal: true

# A story is a single item in a column, which belongs to a board
class Story < ApplicationRecord
  belongs_to :column

  validates :description, presence: true
  validate :due_date_exists_in_future

  enum status: { open: 0, closed: 1, done: 2 }

  # Chain with qualifiers for column and board.
  scope :overdue, -> { self.open.where('due_date < ?', Time.zone.now.to_date) }
  scope :by_status, ->(statuses) { where status: statuses }

  private

  def due_date_exists_in_future
    if due_date.blank?
      errors.add :due_date, 'Due date is required'

    elsif due_date.to_date < Time.zone.now.to_date
      errors.add :due_date, 'Due date must be in the future'
    end
  end
end
