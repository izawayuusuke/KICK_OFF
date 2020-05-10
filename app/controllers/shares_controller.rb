class SharesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def create
    @share = Share.create(user_id: current_user.id, post_id: @post.id)
    @share.save
    @post = Post.new(user_id: @post.user_id,
                    content: @post.content,
                    image: @post.image)
  end

  def destroy
    @share = Share.find_by(user_id: current_user.id, post_id: @post.id)
    @share.destroy
  end
end
