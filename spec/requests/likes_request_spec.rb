require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:post) { create(:post) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      # it "いいねに成功する" do
      #   expect do
      #     post post_like_path, params: { like: { user_id: user.id, post_id: post.id } }
      #   end.to change(Like, :count).by(1)
      # end
    end
  end

  # describe 'DELETE #destroy' do
  #   let(:like) { Like.create(user_id: user.id, post_id: post.id) }
  #   context do
  #     it 'いいねを解除する' do
  #       expect do
  #         delete post_like_path(post), params: { user_id: user.id, post_id: post.id }, xhr: true
  #       end.to change(Like, :count).by(-1)
  #     end
  #   end
  # end
end
