require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'association' do
    context 'belongs_to' do
      it 'post' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end

      it 'comment' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end

      it 'visitor' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end

      it 'visited' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end
end
