class UsersController < ApplicationController
  before_action :set_user
  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :address, :profile_image, :introduction, :official_account)
    end
end
