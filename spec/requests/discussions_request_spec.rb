require 'rails_helper'


RSpec.describe "Discussions", type: :request do
  describe 'POST #create' do
    context 'パラメーターが妥当な場合' do
      let(:user) { create(:user) }
      let(:team) { create(:team) }
      before do
        sign_in user
      end

      it '投稿に成功する' do
        expect do
          post team_discussions_path(team), params: { discussion: FactoryBot.attributes_for(:discussion) }
          expect(response.status).to eq 302
        end.to change(Discussion, :count).by(1)
        expect(Discussion.find_by(user_id: user.id, team_id: team.id)).to_not eq nil
      end

      it 'チーム詳細にリダイレクトする' do
        post team_discussions_path(team), params: { discussion: FactoryBot.attributes_for(:discussion) }
        expect(response).to redirect_to team_path(team)
      end

      it 'パラメーターが不正な場合は投稿に失敗する' do
        expect do
          post team_discussions_path(team), params: { discussion: FactoryBot.attributes_for(:discussion, content: "") }
          expect(response.status).to eq 200
        end.to_not change(Discussion, :count)
        expect(response.body).to include "コメントを入力してください"
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let!(:discussion) { create(:discussion, user_id: user.id, team_id: team.id) }
    before do
      sign_in user
    end

    it '削除に成功する' do
      expect do
        delete team_discussion_path(team, discussion)
        expect(response.status).to eq 302
      end.to change(Discussion, :count).by(-1)
      expect(Discussion.find_by(user_id: user.id, team_id: team.id )).to eq nil
    end

    it 'チーム詳細にリダイレクトする' do
      delete team_discussion_path(team, discussion)
      expect(response).to redirect_to team_path(team)
    end
  end
end
