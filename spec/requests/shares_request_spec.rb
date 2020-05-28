require 'rails_helper'

RSpec.describe "Shares", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:test_post) { create(:post) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it '投稿のシェアに成功する' do
        expect do
          post post_share_path(test_post), params: { share: { user_id: user.id, post_id: test_post.id } }, xhr: true
          expect(response.status).to eq 200
        end.to change(Share, :count).by(1)
        expect(Share.find_by(user_id: user.id, post_id: test_post.id)).to_not eq nil
      end
    end

    context 'ログインしていないとき' do
      it '投稿のシェアに失敗する' do
        expect do
          post post_share_path(test_post), params: { share: { user_id: user.id, post_id: test_post.id } }, xhr: true
        end.to_not change(Share, :count)
        expect(Share.find_by(user_id: user.id, post_id: test_post.id)).to eq nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let!(:share) { create(:share, user_id: user.id, post_id: post.id) }
    before do
      sign_in user
    end

    it 'シェアを解除する' do
      expect do
        delete post_share_path(share), xhr: true
        expect(response.status).to eq 200
      end.to change(Share, :count).by(-1)
      expect(Share.find_by(user_id: user.id, post_id: post.id) ).to eq nil
    end
  end
end
