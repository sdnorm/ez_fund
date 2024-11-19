class ImportParticipantsJob < ApplicationJob
  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)
    import.update!(status: :processing)
    begin
      Participant.import_from_csv(import)
      import.mark_as_completed
    rescue StandardError => e
      import.update!(status: :failed)
      raise e
    end
  end
end
