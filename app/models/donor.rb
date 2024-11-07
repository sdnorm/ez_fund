# == Schema Information
#
# Table name: donors
#
#  id                 :bigint           not null, primary key
#  first_name         :string           not null
#  last_name          :string
#  email_address      :string           not null
#  stripe_customer_id :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Donor < ApplicationRecord
  has_many :purchases
  has_many :campaigns, through: :purchases
  has_many :organizations, through: :purchases
end
