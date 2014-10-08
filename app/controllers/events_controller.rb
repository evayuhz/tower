class EventsController < ApplicationController
  before_action :signed_in_user
  before_action :set_team

  def index
    @events = current_user.visiable_team_events(@team).paginate(:page => params[:page], :per_page => 50)
    @events_group = @events.group_by {|event| event.created_at.to_date  }
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

end
