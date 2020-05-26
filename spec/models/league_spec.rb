require 'rails_helper'

RSpec.describe League, type: :model do
  describe 'validation' do
    let(:league) { build(:league) }
    context 'name' do
      it 'presence true' do
        league.name = ''
        expect(league.valid?).to eq false
      end
    end
  end

  describe 'association' do
    context 'Team' do
      it '1:N' do
        expect(League.reflect_on_association(:teams).macro).to eq :has_many
      end
    end
  end
end
