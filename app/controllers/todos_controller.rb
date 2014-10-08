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
          if change[0] == :status  # enum status: change status string to integer 
            change[1] = Todo.statuses[change[1]]
            change[2] = Todo.statuses[change[2]]         
          end
          @todo.events.create(changed_attr: change[0], old_value: change[1], new_value: change[2],
                                user_id: current_user.id, project_id: @project.id )
        end
      end
    end
end
