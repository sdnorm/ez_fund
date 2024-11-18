class Import < ApplicationRecord
  belongs_to :campaign
  has_one_attached :file

  enum :status, {
    pending: 0,
    processing: 1,
    completed: 2,
    failed: 3
  }

  after_update_commit :cleanup_file, if: :completed?

  private

  def cleanup_file
    file.purge if file.attached?
  end
end
