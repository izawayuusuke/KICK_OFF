require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:test_post) { create(:post) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it '投稿に成功する' do
        expect do
          post post_comments_path(test_post), params: { comment: FactoryBot.attributes_for(:comment) }
          expect(response.status).to eq 302
        end.to change(Comment, :count).by(1)
        expect(Comment.find_by(post_id: test_post.id)).to_not eq nil
      end

      it '投稿詳細にリダイレクトする' do
        post post_comments_path(test_post), params: { comment: FactoryBot.attributes_for(:comment) }
        expect(response).to redirect_to post_path(test_post)
      end

      it 'パラメーターが不正な場合は投稿に失敗する' do
        expect do
          post post_comments_path(test_post), params: { comment: FactoryBot.attributes_for(:comment, comment: "") }
        end.to_not change(Comment, :count)
        expect(response.body).to include "コメントを入力してください"
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let!(:comment) { create(:comment, user_id: user.id, post_id: post.id) }
    before do
      sign_in user
    end

    it '削除に成功する' do
      expect do
        delete post_comment_path(post, comment)
        expect(response.status).to eq 302
      end.to change(Comment, :count).by(-1)
      expect(Comment.find_by(user_id: user.id, post_id: post.id)).to eq nil
    end

    it '投稿詳細にリダイレクトする' do
      delete post_comment_path(post, comment)
      expect(response).to redirect_to post_path(post)
    end
  end
end
