class CommentsController < ApplicationController
  before_action :signed_in_user
  def create
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:todo_id])
    p comment_params.merge(user_id: current_user.id)
    @comment = @todo.comments.new(comment_params.merge(user_id: current_user.id))
    @comment.save
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
