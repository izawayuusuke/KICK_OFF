require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET #index' do
    let!(:posts) { create_list(:post, 10) }
    it '投稿一覧が表示される' do
      get posts_path
      expect(response.status).to eq 200
      expect(response.body).to include "投稿検索"
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post, content: "new_post") }
    it '投稿詳細が表示される' do
      get post_path(post)
      expect(response.status).to eq 200
      expect(response.body).to include "new_post"
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    context 'パラメーターが妥当な場合' do
      before do
        sign_in user
      end

      it '投稿に成功する' do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post) }
          expect(response.status).to eq 302
        end.to change(Post, :count).by(1)
        expect(Post.find_by(user_id: user.id))
      end
    end

    context 'パラメーターが不正な場合' do
      before do
        sign_in user
      end

      it '投稿に失敗する' do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, content: "") }
          expect(response.status).to eq 200
        end.to_not change(Post, :count)
        expect(response.body).to include "投稿内容を入力してください"
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:post) { create(:post) }
    before do
      sign_in post.user
    end

    it '削除に成功する' do
      expect do
        delete post_path(post), xhr: true
        expect(response.status).to eq 200
      end.to change(Post, :count).by(-1)
      expect(Post.find_by(user_id: user.id)).to eq nil
    end
  end
end
