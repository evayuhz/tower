class ProjectsController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource :team
  load_and_authorize_resource :project, through: :team, :shallow => true

  def new
  end

  def create
    @project = @team.projects.new(project_params)
    @project.author_id = current_user.id
    if @project.save
      redirect_to @project 
    else
      render action: "new"
    end
  end

  def index
    @projects =  current_user.visiable_team_projects(@team)
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
    @team = @project.team
    @project.destroy
    redirect_to team_projects_path(@team)
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end

end
