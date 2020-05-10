class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def show
    @posts = (Post.left_joins(:shares).where(shares: { user_id: @user.id }).or(Post.left_joins(:shares).where(user_id: @user.id))).order(created_at: "DESC")
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
