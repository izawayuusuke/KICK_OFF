require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'association' do
    context 'belongs_to' do
      it 'user' do
        expect(Entry.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'room' do
        expect(Entry.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
