class TodosController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource :project 
  load_and_authorize_resource :todo, through: :project
  after_action :create_event, only: [:create, :update, :destroy, :complete]
  
  def new
  end

  def create
    @todo = @project.todos.create(todo_params.merge({ author_id: current_user.id}) )
  end

  def edit
  end

  def update
    @todo.update(todo_params)
  end

  def show
    @team = @project.team
    @user = current_user
    @comment = @todo.comments.new
  end

  def destroy
    @todo.destroy
  end

  def complete
    @todo.update!(status: params[:status])
  end

  private
    def todo_params
      params.require(:todo).permit(:content, :assigned_to, :end_time)
    end


    def create_event
      if @todo.changed_attrs
        @todo.changed_attrs.each do |change|
          content = @todo.send("#{change[:changed_attr]}_event_content", change)
          @todo.events.create(content:content, user_id: current_user.id, project_id: @project.id ) if content
        end
      end
    end
end
