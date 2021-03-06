require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    before do
      sign_in user
    end

    it 'フォローに成功する' do
      expect do
        post relationships_path, params: { relationship: { follower_id: user.id, followed_id: other_user.id } }, xhr: true
        expect(Relationship.last.follower_id).to eq user.id
      end.to change(Relationship, :count).by(1)
      expect(Relationship.find_by(follower_id: user.id, followed_id: other_user.id)).to_not eq nil
    end

    it '相手に通知が送信される' do
      post relationships_path, params: { relationship: { follower_id: user.id, followed_id: other_user.id } }, xhr: true
      expect(Notification.find_by(visitor_id: user.id, visited_id: other_user.id, action: "follow")).to_not eq nil
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:relationship) { create(:relationship, follower_id: user.id, followed_id: other_user.id) }
    before do
      sign_in user
    end

    it 'フォローの解除に成功する' do
      expect do
        delete relationship_path(relationship), params: { relationship: { followed_id: other_user.id } }, xhr: true
      end.to change(Relationship, :count).by(-1)
      expect(Relationship.find_by(follower_id: user.id, followed_id: other_user.id)).to eq nil
    end
  end
end
