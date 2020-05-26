require 'rails_helper'

RSpec.describe Discussion, type: :model do
  describe 'validation' do
    let(:discussion) { build(:discussion) }
    context 'content' do
      it 'presence true' do
        discussion.content = ''
        expect(discussion.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'User' do
      it 'N:1' do
        expect(Discussion.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Team' do
      it 'N:1' do
        expect(Discussion.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
