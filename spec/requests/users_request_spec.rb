require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #index' do
    let(:users) { create_list(:user, 10) }
    it 'ユーザー一覧が表示される' do
      get users_path
      expect(response.status).to eq 200
      expect(response.body).to include "ユーザー検索"
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it 'ユーザー詳細が表示される' do
        get user_path(user)
        expect(response.status).to eq 200
        expect(response.body).to include "編集する"
      end
    end

    context 'ログインしていないとき' do
      it 'リクエストが失敗する' do
        get user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it '編集画面に遷移する' do
        get edit_user_path(user)
        expect(response.status).to eq 200
        expect(response.body).to include "更新する"
      end

      it '自分以外の編集画面に遷移できない' do
        get edit_user_path(other_user)
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'ログインしていないとき' do
      it 'リクエストが失敗する' do
        get edit_user_path(user)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'アカウントの作成テスト' do
      it '作成に成功する' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
          expect(response.status).to eq 302
        end.to change(User, :count).by(1)
        expect(response).to redirect_to posts_path
      end

      it '作成に失敗する' do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user, name: "") }
        end.to_not change(User, :count)
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user, name: "old_name") }
    let(:other_user) { create(:user) }

    context "ユーザーの編集テスト" do
      before do
        sign_in user
      end

      it '編集に成功する' do
        expect do
          patch user_path(user), params: { user: FactoryBot.attributes_for(:user, name: "new_name") }
          expect(response.status).to eq 302
        end.to change { User.find(user.id).name }.from("old_name").to("new_name")
      end

      it '編集に失敗する' do
        expect do
          patch user_path(user), params: { user: FactoryBot.attributes_for(:user, name: "") }
        end.to_not change { User.find(user.id).name }
        expect(response.body).to include "ユーザーネームを入力してください"
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    context '管理者権限を持つとき' do
      before do
        user.admin = true
        sign_in user
      end

      it '削除に成功する' do
        expect do
          delete user_path(other_user)
          expect(response.status).to eq 302
        end.to change(User, :count).by(-1)
      end

      it 'ユーザー一覧にリダイレクトする' do
        delete user_path(other_user)
        expect(response).to redirect_to users_path
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '削除に失敗する' do
        expect do
          delete user_path(other_user)
        end.to_not change(User, :count)
        get users_path
        expect(response.status).to eq 200
        expect(response.body).to include '管理者権限がありません'
      end
    end
  end

  describe 'GET #following' do
    let(:user) { create(:user) }
    let(:relationships) { create_list(:relationship, 10) }
    let(:likes) { create_list(:like, 10) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it 'フォロー一覧が表示される' do
        get following_user_path(user)
        expect(response.status).to eq 200
        expect(response.body).to include "フォロー中"
      end

      it 'フォロワー一覧が表示される' do
        get followers_user_path(user)
        expect(response.status).to eq 200
        expect(response.body).to include "フォロワー"
      end

      it 'いいねした投稿一覧を表示する' do
        get likes_user_path(user)
        expect(response.status).to eq 200
        expect(response.body).to include "いいね"
      end
    end
  end
end
