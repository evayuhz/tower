class TodosController < ApplicationController
  before_action :signed_in_user
  before_action :set_project
  after_action :create_event, only: [:create, :update, :destroy, :complete]
  def new
  end

  def create
    @todo = @project.todos.create(todo_params.merge({ author_id: current_user.id}) )
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
  end

  def show
    @todo = Todo.find(params[:id])
    @team = @project.team
    @user = current_user
    @comment = @todo.comments.new
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  def complete
    @todo = Todo.find(params[:id])
    @todo.update!(status: params[:status])
  end

  private
    def todo_params
      params.require(:todo).permit(:content, :assigned_to, :end_time)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def create_event
      if @todo.attrs_changed_desc
        @todo.attrs_changed_desc.each do |desc|
          @todo.events.create(description: desc, user_id: current_user.id, project_id: @project.id )
        end
      end
    end
end
