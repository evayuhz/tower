class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :set_project, only: :show
  before_action :correct_user, only: :show
  def new
  end

  def index
    @team = Team.find(params[:team_id])
    @projects = @team.visiable_projects(current_user)
    render_403 if !@team.visiable?(current_user)
  end

  def show
    @todos = @project.todos.incomplete
    @completed_todos = @project.todos.completed
    @todo = @project.todos.new
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
      @team = @project.team
    end

    def correct_user
      if !@project.visiable?(current_user)
        render_403
      end
    end
end
