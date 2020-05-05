class PostsController < ApplicationController
  def index
    @posts = Post.all.order(id: "DESC")
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to posts_path
    else
      @user = current_user
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :image)
    end
end
