require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'validation' do
    let(:player) { build(:player) }
    it 'complete all' do
      expect(player).to be_valid
    end

    context 'name' do
      it 'presence true' do
        player.name = ''
        expect(player.valid?).to eq false
      end
    end

    context 'height' do
      it 'presence true' do
        player.height = ''
        expect(player.valid?).to eq false
      end
    end

    context 'weight' do
      it 'presence true' do
        player.weight = ''
        expect(player.valid?).to eq false
      end
    end

    context 'age' do
      it 'presence true' do
        player.age = ''
        expect(player.valid?).to eq false
      end
    end

    context 'uniform_number' do
      it 'presence true' do
        player.uniform_number = ''
        expect(player.valid?).to eq false
      end
    end
  end
end
