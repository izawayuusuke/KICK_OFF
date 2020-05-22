class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    current_user.unfollow(@user)
  end

  private
    def set_user
      @user = User.find(params[:relationship][:followed_id])
    end
end
