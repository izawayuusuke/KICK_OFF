require 'rails_helper'

RSpec.describe Belong, type: :model do
  describe 'association' do
    context 'belongs_to' do
      it 'player' do
        expect(Belong.reflect_on_association(:player).macro).to eq :belongs_to
      end

      it 'team' do
        expect(Belong.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
