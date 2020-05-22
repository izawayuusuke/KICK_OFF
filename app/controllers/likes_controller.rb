class LikesController < ApplicationController
  before_action :set_post
  def create
    @like = Like.create(user_id: current_user.id, post_id: @post.id)
    @post.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end
end
