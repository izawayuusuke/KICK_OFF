require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    let(:post) { build(:post) }
    it 'complete all' do
      expect(post).to be_valid
    end

    context 'content' do
      it 'presence true' do
        post.content = ''
        expect(post.valid?).to eq false
      end

      it 'maximum 150' do
        post.content = 'a' * 151
        expect(post.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'has_many' do
      it 'likes' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end

      it 'comments' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end

      it 'shares' do
        expect(Post.reflect_on_association(:shares).macro).to eq :has_many
      end

      it 'notifications' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end

    context 'belongs_to' do
      it 'user' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

  end
end
