require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'association' do
    context 'Entry' do
      it '1:N' do
        expect(Room.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Message'do
      it '1:N' do
        expect(Room.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
  end
end
