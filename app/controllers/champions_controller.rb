class ChampionsController < ApplicationController
  def index
    @champions = @campaign.champions
  end

  def show
    @champion = @campaign.champions.find(params[:id])
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
end
