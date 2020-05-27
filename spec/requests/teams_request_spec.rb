require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it 'チーム詳細が表示される' do
        get team_path(team)
        expect(response.status).to eq 200
      end

      it '編集リンクボタンが表示される' do
        get team_path(team)
        expect(response.body).to include "編集"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '編集リンクボタンが表示されない' do
        get team_path(team)
        expect(response.body).to_not include "編集"
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

      it 'チームの作成に成功する' do
        expect do
          post teams_path, params: { team: FactoryBot.attributes_for(:team) }
        end.to change(Team, :count).by(1)
      end

      it 'チーム詳細にリダイレクトする' do
        post teams_path, params: { team: FactoryBot.attributes_for(:team) }
        expect(response).to redirect_to team_path(Team.last)
      end

      it 'パラメーターが不正な場合は作成に失敗する' do
        expect do
          post teams_path, params: { team: FactoryBot.attributes_for(:team, name: "") }
        end.to_not change(Team, :count)
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it 'チームの作成に失敗する' do
        expect do
          post teams_path, params: { team: FactoryBot.attributes_for(:team) }
        end.to_not change(Team, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:team) { create(:team, name: "old_name") }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it 'チームの編集に成功する' do
        expect do
          patch team_path(team), params: { team: FactoryBot.attributes_for(:team, name: "new_name") }
        end.to change { Team.find(team.id).name }.from("old_name").to("new_name")
      end

      it 'チーム詳細にリダイレクトする' do
        patch team_path(team), params: { team: FactoryBot.attributes_for(:team, name: "new_name") }
        expect(response). to redirect_to team_path(team)
      end

      it 'パラメーターが不正な場合は編集に失敗する' do
        expect do
          patch team_path(team), params: { team: FactoryBot.attributes_for(:team, name: "") }
        end.to_not change { Team.find(team.id).name }
        expect(response.body).to include "チーム名を入力してください"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it 'チームの編集に失敗する' do
        expect do
          patch team_path(team), params: { team: FactoryBot.attributes_for(:team) }
          expect(response.status).to eq 302
        end.to_not change { Team.find(team.id).name }
      end
    end
  end
end
