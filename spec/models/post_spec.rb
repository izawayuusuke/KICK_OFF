require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    let(:post) { build(:post) }
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
    context 'User' do
      it '1:N' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Like' do
      it '1:N' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
  end
end
