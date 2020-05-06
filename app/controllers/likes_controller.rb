class LikesController < ApplicationController
  before_action :set_post
  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @like.save
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
  end

  def set_post
    @post = Post.find_by(params[:id])
  end
end
