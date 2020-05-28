require 'rails_helper'

RSpec.describe "Players", type: :request do
  describe 'GET #index' do
    let(:players) { create_list(:player, 10) }
    it '選手一覧が表示される' do
      get players_path
      expect(response.status).to eq 200
      expect(response.body).to include "選手検索"
    end
  end

  describe 'GET # show' do
    let(:user) { create(:user) }
    let(:player) { create(:player, name: "player1") }

    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '編集画面へのリンクが表示される' do
        get player_path(player)
        expect(response.status).to eq 200
        expect(response.body).to include "編集"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '選手詳細が表示される' do
        get player_path(player)
        expect(response.status).to eq 200
        expect(response.body).to include "player1"
      end

      it '編集画面へのリンクが表示されない' do
        get player_path(player)
        expect(response.status).to eq 200
        expect(response.body).to_not include "編集"
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    let(:player) { create(:player) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '編集画面が表示される' do
        get edit_player_path(player)
        expect(response.status).to eq 200
        expect(response.body).to include "更新する"
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '編集画面に遷移できない' do
        get edit_player_path(player)
        expect(response.status).to eq 302
        expect(response.body).to_not include "更新する"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:team) { create(:team) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '登録に成功する' do
        params = { belongs_attributes: [ FactoryBot.attributes_for(:belong, team_id: team.id) ] }
        expect do
          post team_players_path(team), params: { player: FactoryBot.attributes_for(:player).merge(params) }
        end.to change(Player, :count).by(1)
        expect(Player.joins(:belong).where(belongs: { team_id: team.id }))
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:player) { create(:player, name: "old_name") }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '編集に成功する' do
        expect do
          patch player_path(player), params: { player: FactoryBot.attributes_for(:player, name: "new_name") }
        end.to change { Player.find(player.id).name }.from("old_name").to("new_name")
      end

      it 'プレイヤー詳細にリダイレクトする' do
        patch player_path(player), params: { player: FactoryBot.attributes_for(:player, name: "new_name") }
        expect(response).to redirect_to player_path(player)
      end

      it 'パラメーターが不正な場合は編集に失敗する' do
        expect do
          patch player_path(player), params: { player: FactoryBot.attributes_for(:player, name: "") }
        end.to_not change { Player.find(player.id).name }
        expect(response.body).to include "名前を入力してください"
      end
    end


    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '編集に失敗する' do
        expect do
          patch player_path(player), params: { player: FactoryBot.attributes_for(:player, name: "new_name") }
        end.to_not change { User.find(player.id).name }
        expect(response).to redirect_to root_path
      end
    end
  end
end
