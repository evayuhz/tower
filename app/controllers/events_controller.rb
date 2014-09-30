class EventsController < ApplicationController
  before_action :signed_in_user
  before_action :set_team

  def index
    @events = current_user.visiable_team_events(@team);
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

end
