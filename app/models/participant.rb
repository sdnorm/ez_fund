class Participant < ApplicationRecord
  belongs_to :champion, optional: true

  has_many :purchases

  has_many :calendar_days

  has_many :campaign_participants
  has_many :campaigns, through: :campaign_participants


  def available_days
    (1..31).to_a - calendar_days.where.not(status: "available").pluck(:day)
  end

  def total_money_raised
    purchases.successful_campaign_purchases(campaign).sum(:amount)
  end

  def self.import_from_csv(import)
    require "csv"

    raise ArgumentError, "No file attached to import" unless import.file.attached?

    begin
      csv_data = import.file.download
      raise ArgumentError, "CSV file is empty" if csv_data.blank?

      CSV.parse(csv_data, headers: true) do |row|
        raise ArgumentError, "Missing required headers" unless valid_headers?(row)

        champion = Champion.find_or_initialize_by(
          first_name: row["champion_first_name"].to_s.strip,
          last_name: row["champion_last_name"].to_s.strip
        )

        if champion.new_record?
          champion.save!
          CampaignChampion.create!(champion: champion, campaign: import.campaign)
        else
          unless CampaignChampion.exists?(champion: champion, campaign: import.campaign)
            CampaignChampion.create!(champion: champion, campaign: import.campaign)
          end
        end

        participant = find_or_initialize_by(
          first_name: row["first_name"].to_s.strip,
          last_name: row["last_name"].to_s.strip
        )

        if participant.new_record?
          participant.save!
          CampaignParticipant.create!(participant: participant, campaign: import.campaign)
        else
          unless CampaignParticipant.exists?(participant: participant, campaign: import.campaign)
            CampaignParticipant.create!(participant: participant, campaign: import.campaign)
          end
        end
      end
    rescue CSV::MalformedCSVError => e
      raise ArgumentError, "Invalid CSV format: #{e.message}"
    end
  end

  private

  def self.valid_headers?(row)
    required_headers = [ "first_name", "last_name", "champion_first_name", "champion_last_name" ]
    required_headers.all? { |header| row.headers.include?(header) }
  end
end
