class Donor < ApplicationRecord
  has_many :purchases
  has_many :campaigns, through: :purchases
  has_many :organizations, through: :purchases
end
