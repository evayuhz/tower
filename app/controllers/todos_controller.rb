class TodosController < ApplicationController
  def new
  end

  def create
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
end
