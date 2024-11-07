class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[ show edit update destroy ]
  before_action :set_organization

  # GET /campaigns or /campaigns.json
  def index
    @campaigns = Campaign.all
  end

  # GET /campaigns/1 or /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = @organization.campaigns.build
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns or /campaigns.json
  def create
    @campaign = @organization.campaigns.build(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to organization_campaign_path(@organization, @campaign), notice: "Campaign was successfully created." }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1 or /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: "Campaign was successfully updated." }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1 or /campaigns/1.json
  def destroy
    @campaign.destroy!

    respond_to do |format|
      format.html { redirect_to organization_campaigns_path(@organization), status: :see_other, notice: "Campaign was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(:start_date, :end_date, :name, :description, :active, :commission_rate)
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end
end
