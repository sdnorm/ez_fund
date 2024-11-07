class Purchase < ApplicationRecord
  belongs_to :participant
  belongs_to :donor
end
