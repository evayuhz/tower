class TeamsController < ApplicationController
  before_action :signed_in_user
  before_action :set_team, only: [:show]
  before_action :correct_user
  def show
    render status: 301, location: team_projects_path(@team)
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def correct_user
      render_403 if !@team.visiable?(current_user)
    end
end
