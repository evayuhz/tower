class UsersController < ApplicationController
  before_action :signed_in_user

  def show
    @user = current_user
    if params[:id] && @user != User.find(params[:id])
      render_403
    end
    @teams = @user.visiable_teams
  end
end
