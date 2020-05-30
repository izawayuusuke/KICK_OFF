require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe 'GET #index' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:test_post) { create(:post, user_id: other_user.id) }
    let!(:comment) { create(:comment, user_id: user.id, post_id: test_post.id) }
    let!(:follow_notification) { create(:notification, visitor_id: other_user.id, visited_id: user.id, action: "follow") }
    let!(:like_notification) { create(:notification, visitor_id: other_user.id, visited_id: user.id, post_id: test_post.id, action: "like") }
    let!(:comment_notification) { create(:notification, visitor_id: other_user.id, visited_id: user.id, post_id: test_post.id, comment_id: comment.id, action: "comment") }
    let!(:unchecked_notification) { create(:notification, visitor_id: other_user.id, visited_id: user.id, action: "follow", checked: false) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it 'フォローの通知が表示される' do
        get notifications_path
        expect(response.status).to eq 200
        expect(response.body).to include "あなたをフォローしました"
      end

      it 'いいねの通知が表示される' do
        get notifications_path
        expect(response.status).to eq 200
        expect(response.body).to include "あなたの投稿", "にいいねしました"
      end

      it 'コメントの通知が表示される' do
        get notifications_path
        expect(response.status).to eq 200
        expect(response.body).to include "あなたの投稿", "にコメントしました"
      end

      it 'checkedの有効化に成功する' do
        expect do
          get notifications_path
          expect(response.status).to eq 200
        end.to change(Notification.where(checked: false), :count).by(-1)
      end
    end

    context 'ログインしていないとき' do
      it '通知一覧に遷移できない' do
        get notifications_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
