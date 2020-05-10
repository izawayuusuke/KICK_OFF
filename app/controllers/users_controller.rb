class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def show
    @posts = @user.posts.order(id: 'DESC')
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def following
    @following = @user.following
  end

  def followers
    @followers = @user.followers
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :address, :profile_image, :introduction, :official_account)
    end
end
