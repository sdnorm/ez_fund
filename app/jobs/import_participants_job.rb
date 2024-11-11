class ImportParticipantsJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)
    campaign = import.campaign
    import.update!(status: :processing)
    import.file.open do |file|
      campaign.import_participants_from_csv(file.path)
    end
    import.update!(status: :completed)
  rescue StandardError => e
    import.update!(
      status: :failed,
      error_message: e.message
    )
    raise e
  end
end
