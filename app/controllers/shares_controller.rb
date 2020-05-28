class SharesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    if user_signed_in?
      @share = Share.create(user_id: current_user.id, post_id: @post.id)
    else
      flash[:warning] = "アカウント作成もしくはログインしてください"
      redirect_to new_user_session_path
    end
  end

  def destroy
    @share = Share.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end
end
