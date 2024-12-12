class Campaign < ApplicationRecord
  acts_as_tenant(:organization)
  belongs_to :organization

  has_many :purchases
  has_many :campaign_champions
  has_many :champions, through: :campaign_champions
  has_many :campaign_participants
  has_many :participants, through: :campaign_participants

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

  # def import_participants_from_csv(file_path)
  #   CSV.foreach(file_path, headers: true) do |row|
  #     champion = Champion.find_or_create_by!(first_name: row["champion_first_name"], last_name: row["champion_last_name"])
  #     if row["champion_email_address"].present?
  #       champion.update!(email_address: row["champion_email_address"])
  #     end

  #     participants.create!(
  #       first_name: row["first_name"],
  #       last_name: row["last_name"],
  #       champion: champion
  #     )
  #   end
  # ensure
  #   # Clean up the temporary file after processing
  #   File.delete(file_path) if File.exist?(file_path)
  # end
end
