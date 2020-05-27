require 'rails_helper'

RSpec.describe "Belongs", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:player) { create(:player) }
    let(:team) { create(:team) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '登録に成功する' do
        expect do
          post player_belongs_path(player), params: { belong: { team_id: team.id } }
        end.to change(Belong, :count).by(1)
        expect(Belong.find_by(player_id: player.id, team_id: team.id)).to_not eq nil
      end

      it 'プレイヤー詳細にリダイレクトする' do
        post player_belongs_path(player), params: { belong: { team_id: team.id } }
        expect(response).to redirect_to edit_player_path(player)
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '登録に失敗する' do
        expect do
          post player_belongs_path(player), params: { belong: { team_id: team.id } }
          expect(response.status).to eq 302
        end.to_not change(Belong, :count)
      end
    end

    context '既にチームに所属している場合' do
      let(:user) { create(:user) }
      let(:player) { create(:player) }
      let(:team) { create(:team) }
      let!(:belong) { create(:belong, player_id: player.id, team_id: team.id) }
      before do
        sign_in user
        user.admin = true
      end

      it '登録に失敗する' do
        expect do
          post player_belongs_path(player), params: { belong: { team_id: team.id, player_id: player.id } }
        end.to_not change(Belong, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:player) { create(:player) }
    let!(:team) { create(:team) }
    let!(:belong) { create(:belong, team_id: team.id, player_id: player.id) }
    context '管理者権限を持つとき' do
      before do
        sign_in user
        user.admin = true
      end

      it '削除に成功する' do
        expect do
          delete team_belong_path(team, belong)
          expect(response.status).to eq 302
        end.to change(Belong, :count).by(-1)
        expect(Belong.find_by(player_id: player.id, team_id: team.id)).to eq nil
      end
    end

    context '管理者権限を持たないとき' do
      before do
        sign_in user
      end

      it '削除に失敗する' do
        expect do
          delete team_belong_path(team, belong)
          expect(response.status).to eq 302
        end.to_not change(Belong, :count)
        expect(response).to redirect_to player_path(player)
      end
    end
  end
end
