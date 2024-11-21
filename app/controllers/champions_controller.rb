class ChampionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_campaign

  def index
    @champions = @campaign.champions
  end

  def show
    @champion = Champion.find(params[:id])
    @campaign = Campaign.find(params[:campaign_id]) if params[:campaign_id]
  end

  def new
    @champion = @campaign.champions.build
  end

  def create
    @champion = @campaign.champions.build(champion_params)
    if @champion.save
      redirect_to organization_campaign_champion_path(@organization, @campaign, @champion), notice: "Champion was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @champion = @campaign.champions.find(params[:id])
  end

  def update
    @champion = @campaign.champions.find(params[:id])
    if @champion.update(champion_params)
      redirect_to organization_campaign_champion_path(@organization, @campaign, @champion), notice: "Champion was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @champion = @campaign.champions.find(params[:id])
    @champion.destroy
    redirect_to organization_campaign_champions_path(@organization, @campaign), notice: "Champion was successfully destroyed."
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end
end
