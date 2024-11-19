class Import < ApplicationRecord
  belongs_to :campaign
  has_one_attached :file

  enum :status, {
    pending: 0,
    processing: 1,
    completed: 2,
    failed: 3
  }

  # validates :file, presence: true
  # validate :file_is_csv

  def mark_as_completed
    transaction do
      update!(status: :completed)
      file.purge if file.attached?
    end
  end

  private

  def file_is_csv
    return unless file.attached?
    unless file.content_type.in?([ "text/csv", "application/csv" ])
      errors.add(:file, "must be a CSV file")
    end
  end
end
