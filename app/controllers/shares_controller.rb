class SharesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @share = Share.create(user_id: current_user.id, post_id: @post.id)
    redirect_to posts_path
  end

  def destroy
    @share = Share.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end
end
