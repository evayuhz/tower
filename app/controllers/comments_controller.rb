class CommentsController < ApplicationController
  before_action :signed_in_user
  after_action :create_event, only: [:create]
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

    def create_event
      if @comment.attrs_changed_desc
        @comment.attrs_changed_desc.each do |desc|
          @comment.events.create(description: desc, user_id: current_user.id, project_id: @project.id )
        end
      end
    end
end
