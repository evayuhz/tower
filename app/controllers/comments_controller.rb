class CommentsController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource :project 
  after_action :create_event, only: [:create]
  
  def create
    if params[:todo_id]
      @todo = Todo.find(params[:todo_id])
      @comment = @todo.comments.new(comment_params.merge(user_id: current_user.id))
      @comment.save
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def create_event
      if @comment.changed_attrs
        @comment.changed_attrs.each do |change|
          content = @comment.send("#{change[:changed_attr]}_event_content", change)
          @comment.events.create(content:content, user_id: current_user.id, project_id: @project.id ) if content
        end
      end
    end
end
