require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'association' do
    context 'Post' do
      it 'N:1' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Comment' do
      it 'N:1' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end

    context 'User' do
      it 'visitor N:1' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end
      it 'visited N:1' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
  end
end
