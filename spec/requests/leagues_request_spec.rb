require 'rails_helper'

RSpec.describe "Leagues", type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:leagues) { create_list(:league, 10) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '登録フォームが表示される' do
        get leagues_path
        expect(response.body).to include "登録する"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it 'リーグ一覧が表示される' do
        get leagues_path
        expect(response.status).to eq 200
        expect(response.body).to include "国内", "海外", "代表"
      end

      it '登録フォームが表示されない' do
        get leagues_path
        expect(response.status).to eq 200
        expect(response.body).to_not include "登録する"
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:league) { create(:league, name: "J1") }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '編集フォームが表示される' do
        get league_path(league)
        expect(response.body).to include "更新する"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it 'リーグ詳細が表示される' do
        get league_path(league)
        expect(response.status).to eq 200
        expect(response.body).to include "J1"
      end

      it '編集フォームが表示されない' do
        get league_path(league)
        expect(response.status).to eq 200
        expect(response.body).to_not include "更新する"
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '登録に成功する' do
        expect do
          post leagues_path, params: { league: FactoryBot.attributes_for(:league, name: "J1") }
        end.to change(League, :count).by(1)
        expect(response.status).to eq 302
        expect(League.find_by(name: "J1")).to_not eq nil
      end

      it 'リーグ詳細にリダイレクトする' do
        post leagues_path, params: { league: FactoryBot.attributes_for(:league) }
        expect(response).to redirect_to league_path(League.last)
      end

      it 'パラメーターが不正な場合は登録に失敗する' do
        expect do
          post leagues_path, params: { league: FactoryBot.attributes_for(:league, name: "") }
        end.to_not change(League, :count)
        expect(response.body).to include "リーグ名を入力してください"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '登録に失敗する' do
        expect do
          post leagues_path, params: { league: FactoryBot.attributes_for(:league) }
          expect(response.status).to eq 302
        end.to_not change(League, :count)
        expect(response).to redirect_to leagues_path
        follow_redirect!
        expect(response.body).to include "管理者権限がありません"
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:league) { create(:league, name: "old_name") }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '編集に成功する' do
        expect do
          patch league_path(league), params: { league: FactoryBot.attributes_for(:league, name: "new_name") }
        end.to change { League.find(league.id).name }.from("old_name").to("new_name")
      end

      it 'リーグ詳細にリダイレクトする' do
        patch league_path(league), params: { league: FactoryBot.attributes_for(:league, name: "new_name") }
        expect(response).to redirect_to league_path(league)
      end

      it 'パラメーターが不正な場合は編集に失敗する' do
        expect do
          patch league_path(league), params: { league: FactoryBot.attributes_for(:league, name: "") }
        end.to_not change { League.find(league.id).name }
        expect(response.body).to include "リーグ名を入力してください"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '編集に失敗する' do
        expect do
          patch league_path(league), params: { league: FactoryBot.attributes_for(:league, name: "new_name") }
          expect(response.status).to eq 302
        end.to_not change { League.find(league.id).name }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #leagues_classification' do
    let(:user) { create(:user) }
    it '国内リーグ一覧が表示される' do
      get leagues_domestic_path
      expect(response.status).to eq 200
      expect(response.body).to include "国内"
    end

    it '海外リーグ一覧が表示される' do
      get leagues_abroad_path
      expect(response.status).to eq 200
      expect(response.body).to include "海外"
    end

    it '代表一覧が表示される' do
      get leagues_representative_path
      expect(response.status).to eq 200
      expect(response.body).to include "代表"
    end
  end
end
