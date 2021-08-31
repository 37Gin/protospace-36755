class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @prototype = Prototype.find(@comment.prototype_id)
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to prototype_path(@comment.prototype_id)
    else
      render template: "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
