require "csv"

class ParticipantsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_campaign

  def index
    @pagy, @participants = pagy(@campaign.participants.includes(:purchases), items: 25)
  end

  def show
    @participant = @campaign.participants.find(params[:id])
  end

  def edit
    @participant = @campaign.participants.find(params[:id])
  end

  def update
    @participant = @campaign.participants.find(params[:id])
    if @participant.update(participant_params)
      redirect_to organization_campaign_participant_path(@organization, @campaign, @participant),
        notice: "Participant updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def import
  end

  def process_import
    puts "process_import"
    if params[:file].present?
      import = @campaign.imports.build(
        status: :pending,
        filename: params[:file].original_filename
      )
      import.campaign = @campaign
      import.save!
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

  def download_qr_code
    return head :not_found unless @participant.unique_calendar_link.present?

    qrcode = RQRCode::QRCode.new(@participant.unique_calendar_link)
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: 400,
      resize_gte_to: false,
    )

    send_data png.to_s, 
      filename: "calendar-qr-#{@participant.id}.png",
      type: "image/png",
      disposition: "attachment"
  end

  private

  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :champion_id)
  end

  def set_organization
    @organization = current_user.organizations.find(params[:organization_id])
  end

  def set_campaign
    @campaign = @organization.campaigns.includes(:champions).find(params[:campaign_id])
  end
end
