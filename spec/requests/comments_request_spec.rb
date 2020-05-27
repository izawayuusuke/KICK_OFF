require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:post) { create(:post) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

    #   it '投稿に成功する' do
    #     post post_comments_path, create(id: comment.id, user_id: user.id, post_id: post.id)
    #     expect(response.status).to eq 302
    #   end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:post) { create(:post) }
    let!(:comment) { create(:comment, user_id: user.id, post_id: post.id) }
    let!(:other_comment) { create(:comment, user_id: other_user.id, post_id: post.id) }
    before do
      sign_in user
    end

    it '削除に成功する' do
      expect do
        delete post_comment_path(post, comment)
        expect(response.status).to eq 302
      end.to change(Comment, :count).by(-1)
    end

    it '投稿詳細にリダイレクトする' do
      expect do
        delete post_comment_path(post, comment)
        expect(response.status).to eq 302
      end.to change(Comment, :count).by(-1)
      expect(response).to redirect_to post_path(post)
    end
  end
end
