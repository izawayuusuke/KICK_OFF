class PostsController < ApplicationController
  before_action :post_find, only: [:show, :destroy]
  def index
    @posts = Post.all.order(id: "DESC")
    @post = Post.new
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(id: "DESC")
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

  def destroy
    @post.destroy
    @post_id = @post.id
    path = Rails.application.routes.recognize_path(request.referrer)
    if path == { :controller=>"posts", :action=>"show", :id=>"#{@post.id}" }
      redirect_to posts_path
    end
  end

  private
    def post_find
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :image)
    end
end
