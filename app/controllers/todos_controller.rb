class TodosController < ApplicationController
  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @todo = @project.todos.create(todo_params.merge({ author_id: current_user.id}) )
  end

  def edit
  end

  def show
  end

  def complete
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:id])
    @todo.update!(status: params[:status])
  end

  private
    def todo_params
      params.require(:todo).permit(:content, :assigned_to, :end_time)
    end
end
