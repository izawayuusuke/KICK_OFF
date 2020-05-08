require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user) }
    context 'name' do
      let(:test_user) { user }
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

    context 'Relationship' do
      it 'active_relationships 1:N' do
        expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
      it 'passive_relationships 1:N' do
        expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end
    end
  end
end
