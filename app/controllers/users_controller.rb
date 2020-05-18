class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :following, :followers, :likes]
  before_action :correct_user?, only: [:edit, :update]

  def show
    # ユーザーがシェアした投稿とユーザーの投稿を同時に取得する
    @posts = Post.left_joins(:shares).where(shares: { user_id: @user.id })
              .or(
              Post.left_joins(:shares).where(user_id: @user.id))
              .order(created_at: :desc)

    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id then
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def likes
    @like_posts = Post.joins(:likes).where(likes: { user_id: @user.id })
                  .order(created_at: :desc)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def correct_user?
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

    def user_params
      params.require(:user).permit(:name, :address, :profile_image, :introduction, :official_account)
    end
end
