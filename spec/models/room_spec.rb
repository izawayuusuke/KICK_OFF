require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'association' do
    context 'has_many' do
      it 'entries' do
        expect(Room.reflect_on_association(:entries).macro).to eq :has_many
      end

      it 'messages' do
        expect(Room.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
  end
end
