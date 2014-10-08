class CommentsController < ApplicationController
  before_action :signed_in_user
  after_action :create_event, only: [:create]
  
  def create
    @project = Project.find(params[:project_id])
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.new(comment_params.merge(user_id: current_user.id))
    @comment.save
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def create_event
      if @comment.changed_attrs
        @comment.changed_attrs.each do |change|
          @comment.events.create(changed_attr: change[0], old_value: change[1], new_value: change[2],
                              user_id: current_user.id, project_id: @project.id )
        end
      end
    end
end
