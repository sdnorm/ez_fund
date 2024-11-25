class CampaignsController < ApplicationController
  set_current_tenant_through_filter
  before_action :set_organization
  before_action :set_campaign, only: [ :show, :edit, :update, :destroy ]

  def index
    @campaigns = policy_scope(Campaign)
  end

  def show
    authorize @campaign
  end

  def new
    @campaign = Campaign.new
    authorize @campaign
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.organization = @organization
    authorize @campaign

    if @campaign.save
      redirect_to organization_campaign_path(@organization, @campaign), notice: "Campaign was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @campaign
  end

  def update
    authorize @campaign

    if @campaign.update(campaign_params)
      redirect_to organization_campaign_path(@organization, @campaign), notice: "Campaign was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @campaign
    @campaign.destroy
    redirect_to campaigns_path, notice: "Campaign was successfully destroyed."
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
    set_current_tenant(@organization)
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:name, :description, :start_date, :end_date, :goal, :active, :commission_rate)
  end
end
