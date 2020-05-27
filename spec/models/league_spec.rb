require 'rails_helper'

RSpec.describe League, type: :model do
  describe 'validation' do
    let(:league) { build(:league) }
    it 'complete all' do
      expect(league).to be_valid
    end

    context 'name' do
      it 'presence true' do
        league.name = ''
        expect(league.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'has_many' do
      it 'teams' do
        expect(League.reflect_on_association(:teams).macro).to eq :has_many
      end
    end
  end
end
