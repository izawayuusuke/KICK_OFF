require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:test_post) { create(:post) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it "いいねに成功する" do
        expect do
          post post_like_path(test_post), params: { like: { user_id: user.id, post_id: test_post.id } }, xhr: true
          expect(response.status).to eq 200
        end.to change(Like, :count).by(1)
        expect(Like.find_by(user_id: user.id, post_id: test_post.id)).to_not eq nil
      end
    end

    context 'ログインしていないとき' do
      it 'いいねに失敗する' do
        expect do
          post post_like_path(test_post), params: { like: { user_id: user.id, post_id: test_post.id } }
        end.to_not change(Like, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:test_post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: test_post.id) }
    context do
      before do
        sign_in user
      end

      it 'いいねを解除する' do
        expect do
          delete post_like_path(like), xhr: true
          expect(response.status).to eq 200
        end.to change(Like, :count).by(-1)
        expect(Like.find_by(user_id: user.id, post_id: test_post.id)).to eq nil
      end
    end
  end
end
