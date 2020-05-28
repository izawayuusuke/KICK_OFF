require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET #index' do
    let(:post) { create(:post) }
    it '投稿一覧が表示される' do
      get posts_path
      expect(response.status).to eq 200
      expect(response.body).to include "投稿検索"
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }
    it '投稿詳細が表示される' do
      get post_path(post)
      expect(response.status).to eq 200
      expect(response.body).to include "コメント"
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
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:post) { create(:post) }
    context '自分の投稿の場合' do
      before do
        sign_in post.user
      end

      it '削除に成功する' do
        expect do
          delete post_path(post), xhr: true
          expect(response.status).to eq 200
        end.to change(Post, :count).by(-1)
      end
    end

    context '自分以外の投稿の場合' do
      before do
        sign_in user
      end

      it '削除に失敗する' do
        expect do
          delete post_path(post), xhr: true
          expect(response.status).to eq 200
        end.to_not change(Post, :count)
      end
    end
  end
end
