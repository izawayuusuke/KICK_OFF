require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:comment) { build(:comment) }
    context 'comment' do
      it 'presence true' do
        comment.comment = ''
        expect(comment.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'User' do
      it 'N:1' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Post' do
      it 'N:1' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Notification' do
      it '1:N' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end
