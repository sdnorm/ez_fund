class Donor < ApplicationRecord
  # Relationships
  has_many :calendar_days
  has_many :purchases, dependent: :restrict_with_error
end
