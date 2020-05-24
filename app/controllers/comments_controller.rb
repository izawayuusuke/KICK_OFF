class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントを投稿しました"
      redirect_to @post
    else
      @comments = @post.comments.recent.paginate(params, 5)
      render 'posts/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:danger] = "コメントを削除しました"
    redirect_to @post
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
