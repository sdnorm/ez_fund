class Import < ApplicationRecord
  belongs_to :campaign
  has_one_attached :file

  enum status: {
    pending: "pending",
    processing: "processing",
    completed: "completed",
    failed: "failed"
  }

  after_update_commit :cleanup_file, if: :completed?

  private

  def cleanup_file
    file.purge if file.attached?
  end
end
