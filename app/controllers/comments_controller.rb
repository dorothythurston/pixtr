class CommentsController < ApplicationController
  def show
  end

  def create
    image = Image.find(params[:image_id])
    @comment =image.comments.new(comment_params)
    if @comment.save
      current_user.notify_follower(@comment, 'CommentActivity')
    else
      alert "Cannot comment with an empty comment"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end 
end
