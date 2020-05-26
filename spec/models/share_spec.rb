require 'rails_helper'

RSpec.describe Share, type: :model do
  describe 'association' do
    context 'belongs_to' do
      it 'user' do
        expect(Share.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'post' do
        expect(Share.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
