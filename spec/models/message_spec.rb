require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validation' do
    let(:message) { build(:message) }
    context 'content' do
      it 'presence true' do
        message.content = ''
        expect(message.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'belongs_to' do
      it 'user' do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'room' do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
