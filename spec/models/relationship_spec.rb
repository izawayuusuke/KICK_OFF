require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validation' do
    let(:relationship) { build(:relationship) }
    context 'follower_id' do
      it 'presence true' do
        relationship.follower_id = ''
        expect(relationship.valid?).to eq false
      end
    end

    context 'followed_id' do
      it 'presence true' do
        relationship.followed_id = ''
        expect(relationship.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'belongs_to' do
      it 'follower' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end

      it 'followed' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
