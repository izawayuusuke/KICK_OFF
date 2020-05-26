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
    context 'Post' do
      it '1:N' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Like' do
      it '1:N' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end

    context 'Comment' do
      it '1:N' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Share' do
      it '1:N' do
        expect(User.reflect_on_association(:shares).macro).to eq :has_many
      end
    end

    context 'Entry' do
      it '1:N' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Message' do
      it '1:N' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context 'Discussion' do
      it '1:N' do
        expect(User.reflect_on_association(:discussions).macro).to eq :has_many
      end
    end

    context 'Relationship' do
      it 'active_relationships 1:N' do
        expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
      it 'passive_relationships 1:N' do
        expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end
    end

    context 'Notification' do
      it 'active_notifications 1:N' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it 'passive_notifications 1:N' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end
