require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validation' do
    let(:team) { build(:team) }
    context 'name' do
      it 'presence true' do
        team.name = ''
        expect(team.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'Player' do
      it '1:N' do
        expect(Team.reflect_on_association(:players).macro).to eq :has_many
      end
    end

    context 'Belong' do
      it '1:N' do
        expect(Team.reflect_on_association(:belongs).macro).to eq :has_many
      end
    end

    context 'Discussion' do
      it '1:N' do
        expect(Team.reflect_on_association(:discussions).macro).to eq :has_many
      end
    end
  end
end
