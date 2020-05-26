require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user) }
    context 'name' do
      it 'presence true' do
        user.name = ''
        expect(user.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'has_many' do
      it 'posts' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end

      it 'likes' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end

      it 'comments' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end

      it 'shares' do
        expect(User.reflect_on_association(:shares).macro).to eq :has_many
      end

      it 'entries' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end

      it 'messages' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end

      it 'discussions' do
        expect(User.reflect_on_association(:discussions).macro).to eq :has_many
      end

      it 'active_relationships' do
        expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
      it 'passive_relationships' do
        expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end

      it 'active_notifications' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it 'passive_notifications' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end
