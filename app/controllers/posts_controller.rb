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
      flash[:primary] = "投稿しました"
      redirect_to posts_path
    else
      @posts = Post.all.order(id: "DESC")
      render :index
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :image)
    end
end
