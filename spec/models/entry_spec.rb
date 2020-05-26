require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'association' do
    context 'User' do
      it 'N:1' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Room' do
      it 'N:1' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
