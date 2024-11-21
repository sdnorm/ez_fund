class Participant < ApplicationRecord
  belongs_to :campaign
  belongs_to :champion, optional: true
  has_many :purchases

  validates :unique_calendar_link, uniqueness: true

  before_create :generate_unique_calendar_link

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
        champion = Champion.find_or_create_by!(
          first_name: row["champion_first_name"].to_s.strip,
          last_name: row["champion_last_name"].to_s.strip,
          campaign: import.campaign
        )
        create!(
          first_name: row["first_name"].to_s.strip,
          last_name: row["last_name"].to_s.strip,
          champion: champion,
          campaign: import.campaign
        )
      end
    rescue CSV::MalformedCSVError => e
      raise ArgumentError, "Invalid CSV format: #{e.message}"
    end
  end

  def generate_unique_calendar_link
    max_attempts = 5
    attempt = 0
    begin
      attempt += 1
      self.unique_calendar_link = SecureRandom.uuid.delete("-")
      self.save!
    rescue ActiveRecord::RecordInvalid => e
      if attempt < max_attempts && e.record.errors.include?(:unique_calendar_link)
        Rails.logger.warn "Calendar link collision occurred (attempt #{attempt})"
        retry
      end
      raise e
    end
  end

  private

  def self.valid_headers?(row)
    required_headers = [ "first_name", "last_name", "champion_first_name", "champion_last_name" ]
    required_headers.all? { |header| row.headers.include?(header) }
  end
end
