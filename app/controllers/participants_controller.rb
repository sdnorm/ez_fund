require "csv"

class ParticipantsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_campaign

  def index
    @pagy, @participants = pagy(@campaign.participants, items: 25)
  end

  def import
  end

  def process_import
    if params[:file].present?
      import = @campaign.imports.create!(
        status: :pending,
        filename: params[:file].original_filename
      )
      import.file.attach(params[:file])
      ImportParticipantsJob.perform_later(import.id)
      redirect_to organization_campaign_path(@organization, @campaign),
        notice: "Import started. You will be notified when it is done or if there is an issue."
    else
      redirect_to import_organization_campaign_participants_path(@organization, @campaign),
        alert: "Please select a file to import."
    end
  rescue StandardError => e
    redirect_to import_organization_campaign_participants_path(@organization, @campaign),
      alert: "Error scheduling import: #{e.message}"
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_campaign
    @campaign = @organization.campaigns.find(params[:campaign_id])
  end
end
