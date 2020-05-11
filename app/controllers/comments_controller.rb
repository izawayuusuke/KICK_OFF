class CommentsController < ApplicationController
  before_action :set_post
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comments = @post.comments.order(created_at: :desc)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comments = @post.comments.order(created_at: :desc)
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
