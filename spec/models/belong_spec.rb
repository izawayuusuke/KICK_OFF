require 'rails_helper'

RSpec.describe Belong, type: :model do
  describe 'association' do
    context 'Player' do
      it 'N:1' do
        expect(Belong.reflect_on_association(:player).macro).to eq :belongs_to
      end
    end

    context 'Team' do
      it 'N:1' do
        expect(Belong.reflect_on_association(:team).macro).to eq :belongs_to
      end
    end
  end
end
