class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :set_project, only: :show
  before_action :correct_user, only: :show
  def new
  end

  def index
    @projects = current_user.projects
  end

  def show
    @todos = @project.todos.incomplete
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def correct_user
      if current_user != @project.team.leader # todo: should be team member
        render_403
      end
    end
end
