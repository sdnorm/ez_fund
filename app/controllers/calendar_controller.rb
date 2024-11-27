class CalendarController < ApplicationController
  before_action :set_all_the_calendar_things

  def main
  end

  def detail
    @selected_days = params[:seleced_day]
    @total = @selected_day
  end

  private

  def set_all_the_calendar_things
    @campaign_participant = CampaignParticipant.find_by(unique_calendar_link: params[:code])
    @participant = @campaign_participant.participant
    @campaign = @campaign_participant.campaign
    @organization = @campaign.organization
    @calendar_days = @participant.calendar_days.includes(:participant)
  end
end
