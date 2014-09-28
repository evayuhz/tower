class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :set_project, only: :show
  before_action :correct_user, only: :show
  def new
  end

  def index
    @team = Team.find(params[:team_id])
    @projects = @team.projects.select { |project| project.visiable?(current_user)}
    render_403 if !@team.visiable?(current_user)
  end

  def show
    @team = @project.team
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
    end

    def correct_user
      if !@project.visiable?(current_user)
        render_403
      end
    end
end
