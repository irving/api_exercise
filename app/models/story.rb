class Story < ApplicationRecord
  belongs_to :column

  validates :description, presence: true
  validate :due_date_exists_in_future

  private

  def due_date_exists_in_future
    if due_date.blank?
      errors.add :due_date, "Due date is required"

    elsif due_date.to_date < Time.zone.now.to_date
      errors.add :due_date, "Due date must be in the future"
    end
  end
end
