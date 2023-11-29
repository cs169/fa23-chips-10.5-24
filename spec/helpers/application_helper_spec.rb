# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  before do
    create(:state)
  end

  describe '.state_ids_by_name' do
    it 'returns a hash of state names and ids' do
      expect(described_class.state_ids_by_name).to eq({ 'California' => 1 })
    end
  end

  describe '.state_symbols_by_name' do
    it 'returns a hash of state names and symbols' do
      expect(described_class.state_symbols_by_name).to eq({ 'California' => 'CA' })
    end
  end

  describe '.nav_items' do
    it 'returns an array' do
      expect(described_class.nav_items).to be_an(Array)
    end
  end
end
