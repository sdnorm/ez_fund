# == Schema Information
#
# Table name: campaigns
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  start_date      :datetime         not null
#  end_date        :datetime         not null
#  name            :string           not null
#  description     :text
#  active          :boolean          default(TRUE)
#  commission_rate :decimal(, )      default(5.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  goal            :decimal(, )
#
class Campaign < ApplicationRecord
  belongs_to :organization
  has_many :purchases

  has_many :participants
  has_many :champions

  has_many :imports, dependent: :destroy

  def total_money_raised
    purchases.sum(:amount)
  end

  def progress
    (total_money_raised / goal) * 100 unless goal.nil? || goal == 0
  end

  def days_left
    (end_date.to_date - Date.today).to_i
  end

  def import_participants_from_csv(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      champion = Champion.find_or_create_by!(first_name: row["champion_first_name"], last_name: row["champion_last_name"])
      if row["champion_email_address"].present?
        champion.update!(email_address: row["champion_email_address"])
      end

      participants.create!(
        first_name: row["first_name"],
        last_name: row["last_name"],
        champion: champion
      )
    end
  ensure
    # Clean up the temporary file after processing
    File.delete(file_path) if File.exist?(file_path)
  end
end
