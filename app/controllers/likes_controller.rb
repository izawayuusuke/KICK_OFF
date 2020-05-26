class LikesController < ApplicationController
  before_action :set_post

  def create
    if user_signed_in?
      @like = Like.create(user_id: current_user.id, post_id: @post.id)
      @post.create_notification_like!(current_user)
    else
      flash[:warning] = "アカウント作成もしくはログインしてください"
      redirect_to posts_path
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end
end
