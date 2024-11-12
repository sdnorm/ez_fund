class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

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
    authorize @campaign

    if @campaign.save
      redirect_to @campaign, notice: "Campaign was successfully created."
    else
      render :new
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end
end
