require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:room) { create(:room) }
    let!(:entry1) { create(:entry, user_id: user.id, room_id: room.id) }
    let!(:entry2) { create(:entry, user_id: other_user.id, room_id: room.id) }
    let!(:message) { create(:message, content: "message", user_id: other_user.id, room_id: room.id) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it 'メッセージ一覧が表示される' do
        get rooms_path
        expect(response.status).to eq 200
        expect(response.body).to include "message"
      end
    end

    context 'ログインしていないとき' do
      it 'メッセージ一覧に遷移できない' do
        get rooms_path
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:room) { create(:room) }
    let!(:entry) { create(:entry, user_id: other_user.id, room_id: room.id) }
    let!(:entry2) { create(:entry, user_id: user.id, room_id: room.id) }
    context 'ログインしているとき' do
      before do
        sign_in user
      end

      it 'メッセージルームが表示される' do
        get room_path(room)
        expect(response.status).to eq 200
        expect(response.body).to include "textarea"
      end
    end

    context 'ログインしていないとき' do
      it 'メッセージルームに遷移できない' do
        get room_path(room)
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    context 'ログインしているかつ、entryがない場合' do
      before do
        sign_in user
      end

      it 'ルームを作成する' do
        expect do
          post rooms_path, params: { entry: { user_id: other_user.id } }
          expect(response.status).to eq 302
        end.to change(Room, :count).by(1)
      end

      it 'エントリーを作成する' do
        expect do
          post rooms_path, params: { entry: { user_id: other_user.id } }
          expect(response.status).to eq 302
        end.to change(Entry, :count).by(2)
        expect(Entry.first.user != Entry.second.user).to eq true
      end

      it 'メッセージ画面にリダイレクトする' do
        post rooms_path, params: { entry: { user_id: other_user.id } }
        expect(response).to redirect_to room_path(Room.last)
      end
    end

    context 'ログインしていないとき' do
      it 'ルームを作成しない' do
        expect do
          post rooms_path, params: { entry: { user_id: other_user.id } }
        end.to_not change(Room, :count)
      end

      it 'エントリーを作成しない' do
        expect do
          post rooms_path, params: { entry: { user_id: other_user.id } }
        end.to_not change(Entry, :count)
      end

      it 'ログイン画面にリダイレクトする' do
        post rooms_path, params: { entry: { user_id: other_user.id } }
        expect(response.status).to eq 302
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
