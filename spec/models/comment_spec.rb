require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:comment) { build(:comment) }
    it 'complete all' do
      expect(comment).to be_valid
    end

    context 'comment' do
      it 'presence true' do
        comment.comment = ''
        expect(comment.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'has_many' do
      it 'notifications' do
        expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end

    context 'belongs_to' do
      it 'user' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'post' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
