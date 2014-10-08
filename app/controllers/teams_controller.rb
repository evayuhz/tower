class TeamsController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource

  def show
    render status: 301, location: team_projects_path(@team)
  end
end
