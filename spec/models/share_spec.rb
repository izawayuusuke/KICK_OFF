require 'rails_helper'

RSpec.describe Share, type: :model do
  describe 'association' do
    context 'User' do
      it 'N:1' do
        expect(Share.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Post' do
      it 'N:1' do
        expect(Share.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
