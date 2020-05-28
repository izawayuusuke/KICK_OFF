require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validation' do
    let(:team) { build(:team) }
    it 'complete all' do
      expect(team).to be_valid
    end

    context 'name' do
      it 'presence true' do
        team.name = ''
        expect(team.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'has_many' do
      it 'players' do
        expect(Team.reflect_on_association(:players).macro).to eq :has_many
      end

      it 'belongs' do
        expect(Team.reflect_on_association(:belongs).macro).to eq :has_many
      end

      it 'discussions' do
        expect(Team.reflect_on_association(:discussions).macro).to eq :has_many
      end
    end
  end
end
